import os
import time
import logging

from datetime import datetime

import pandas as pd
import xlsxwriter

from colorama import Fore
from tqdm import tqdm

from myapp.core.query.fetch_data import DatabaseManager
from myapp.settings import export_file_path


class DataExporter:
    def __init__(self):
        self.database_manager = DatabaseManager()

    def export(self, table_name, query, export_format=None, file_name=None, append_data=None, output_path=None):
        """
        Export table data to the specified file format.
        :param table_name: Name of the table to export.
        :param query: SQL query to fetch the table data.
        :param export_format: File format to export.
        :param file_name: Name of the output file(optional)
        :param append_data: Flag indicating whether to append data to an existing file(optional)
        :param output_path: Path to the output directory(optional)
        :returns: None
        """
        start_time = time.monotonic()
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        try:
            # Create export directory if it does not exist
            export_path = export_file_path
            os.makedirs(export_path, exist_ok=True)

            # Create file path with file extension
            file_extension = '.' + export_format.lower()
            if file_name is None:
                file_name = f"{table_name}_{timestamp}{file_extension}"
            else:
                file_name += file_extension

            # Combine file path and name
            file_path = os.path.join(export_path, file_name)

            # Check if file exists and handle append option
            if append_data and os.path.isfile(file_path):
                if export_format == 'csv':
                    mode = 'a'
                else:
                    raise ValueError(f"Append option not supported for {export_format} format")
            else:
                mode = 'w'

            if export_format == 'xlsx':
                self._export_to_excel(file_path, table_name, query)
                print(f"\nData exported to {file_path}")
                print("--- %s seconds ---" % (time.monotonic() - start_time))

            elif export_format == 'csv':
                self._export_to_csv(file_path, mode, query)
                print(f"\nData exported to {file_path}")
                print("--- %s seconds ---" % (time.monotonic() - start_time))

            elif export_format == 'json':
                self._export_to_json(file_path, query)
                print(Fore.LIGHTBLUE_EX, "--- %s seconds ---" % (time.monotonic() - start_time))

            else:
                # raise an error if export format is not supported
                raise ValueError(f"Unsupported export format: {export_format}")

        except Exception as e:
            # log the error message
            logging.error(f"An error occurred while exporting table data: {e}")

        finally:
            # Log the completion message
            logging.info("Export operation completed.")

    def _export_to_excel(self, file_path, table_name, query):
        """
        Export table data to an Excel file.

        :param file_path: Path to the output Excel file.
        :param table_name: Name of the table being exported.
        :param query: SQL query to fetch the table data.
        :return: None
        """
        # fetch data from the table
        header, rows = self.database_manager.fetch_table_data(query)

        # Create a new Excel workbook and add a worksheet
        workbook = xlsxwriter.Workbook(file_path)
        worksheet = workbook.add_worksheet(table_name)

        # Apply formatting to the worksheet
        # Set column widths
        column_widths = [len(str(header)) + 2 for header in header]
        for i, width in enumerate(column_widths):
            worksheet.set_column(i, i, width)

        # Create a format for the header cells
        header_format = workbook.add_format({'bold': True, 'bg_color': '#D3D3D3'})

        # Create a format for the data cells with grid lines
        data_format = workbook.add_format({'border': 1, 'border_color': '#D3D3D3'})

        # Write the header row
        for i, header in enumerate(header):
            worksheet.write(0, i, header, header_format)

        # Write the data rows with tqdm progress bar
        with tqdm(total=len(rows), desc='Exporting data', unit='row') as progress_bar:
            for row_num, row_data in enumerate(rows, start=1):
                for col_num, cell_data in enumerate(row_data):
                    worksheet.write(row_num, col_num, cell_data, data_format)
                progress_bar.update(1)

        # Close the workbook
        workbook.close()

        print(f"\nData exported to {file_path}")

    def _export_to_csv(self, file_path, mode, query):
        """
        Export table data to a CSV file.

        :param file_path: Path to the output CSV file.
        :param mode: File write mode ('w' for write, 'a' for append).
        :param query: SQL query to fetch the table data.
        :returns: None
        """
        # fetch data from the table
        header, rows = self.database_manager.fetch_table_data(query)

        # Create a DataFrame
        df = pd.DataFrame(rows, columns=header)

        # Create a progress bar
        progress_bar = tqdm(total=len(df), desc='Exporting to CSV', unit='row')
        # Write DataFrame to CSV file
        with open(file_path, mode, newline='') as csvfile:
            df.to_csv(csvfile, header=(mode == 'w'), index=False, lineterminator='\n', chunksize=1000, encoding='utf-8')

        progress_bar.update(len(df))

        progress_bar.close()

    def _export_to_json(self, file_path, query):
        """
        Export table data to a JSON file.

        :param file_path: Path to the output JSON file.
        :param query: SQL query to fetch the table data.
        :returns: None
        """
        # fetch data from the table
        header, rows = self.database_manager.fetch_table_data(query)

        # Create a DataFrame
        df = pd.DataFrame(rows, columns=header)

        # Create a progress bar
        progress_bar = tqdm(total=len(df), desc='Exporting to JSON', unit='row')

        # Write DataFrame to JSON file
        with open(file_path, 'w') as jsonfile:
            df.to_json(jsonfile, orient='records', indent=4)

        progress_bar.update(len(df))
        progress_bar.close()
