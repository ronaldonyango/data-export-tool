import logging
import schedule
import time

from yaspin import yaspin
from yaspin.spinners import Spinners

from core.query.db_functions import QueryManager
from core.export.engine import DataExporter
from scheduler.interface.schedule_user_interface import ExportPrompter


class ExportScheduler:
    """
    Class to schedule and execute table data exports at specified times.

    Attributes:
        query_manager (QueryManager): Instance of QueryManager class for managing database queries.
        data_exporter (DataExporter): Instance of DataExporter class for exporting table data.
        export_prompter (ExportPrompter): Instance of ExportPrompter class for user interaction.
        tables_and_queries (list): List of available tables and queries.
        export_times (list): List of export times.
        selected_tables_and_queries (list): List of selected tables and queries for export.
        export_format (str): Export format (csv, xlsx, json).

    Methods:
        schedule_exports(): Schedule table data exports at specified times.
        export_table_data(table_name, query, export_format): Export table data for a given table and query.
        run(): Run the export scheduler.
    """

    def __init__(self):
        self.query_manager = QueryManager()
        self.data_exporter = DataExporter()
        self.export_prompter = ExportPrompter()
        self.tables_and_queries = []
        self.export_times = []
        self.selected_tables_and_queries = []
        self.export_format = ""

    def schedule_exports(self) -> None:
        """
        Schedule table data exports at specified times.

        :returns: None
        """
        for export_time in self.export_times:
            for table_name, query in self.selected_tables_and_queries:
                try:
                    # Schedule the export task for the current time and format
                    schedule.every().day.at(export_time).do(
                        self.export_table_data, table_name, query, self.export_format
                    )
                    logging.info(f"Export scheduled for {table_name} at {export_time}")
                except ValueError as ve:
                    logging.error(f"Failed to schedule export for {table_name}: {str(ve)}")

    def export_table_data(self, table_name: str, query: str, export_format: str) -> None:
        """
        Export table data for a given table and query.

        :param table_name: Name of the table to export.
        :param query: SQL query to fetch the table data.
        :param export_format: Export format.
        :return: None
        """
        try:
            # Export the data using the selected options
            self.data_exporter.export(table_name, query, export_format)
            logging.info("Data exported successfully!")
        except Exception as e:
            logging.error(f"An error occurred while exporting table data: {e}")

    def run(self):
        """
        Run the export scheduler.

        :return: None
        """
        try:
            # Fetch available tables and queries from the database
            self.tables_and_queries = self.query_manager.retrieve_preset_queries()

            # Prompt the user for export times
            self.export_times = self.export_prompter.prompt_export_times()

            # Prompt the user to select tables/queries to export
            self.selected_tables_and_queries = self.export_prompter.prompt_table_selection(self.tables_and_queries)

            # Prompt the user for export format
            available_formats = ["csv", "xlsx", "json"]
            self.export_format = self.export_prompter.prompt_export_format(available_formats)

            # Schedule the exports at the specified times
            self.schedule_exports()

            # Run the schedule tasks
            with yaspin(Spinners.dots) as spinner:
                while True:
                    schedule.run_pending()
                    time.sleep(1)
                    spinner.text = "Waiting for next export..."
        except KeyboardInterrupt:
            logging.info("Export script stopped by user.")
