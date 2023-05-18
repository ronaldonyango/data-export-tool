import logging
from typing import Any

from colorama import Fore
from prompt_toolkit import prompt

from myapp.core.query.db_functions import QueryManager


class QueryPrompter:
    @staticmethod
    def update_query(query_manager: QueryManager) -> None:
        """
        Update a query in the database.

        :param query_manager: An instance for the QueryManager class.
        :return: None
        """
        print("\n" + Fore.BLUE + "Available queries:")
        try:
            queries = query_manager.retrieve_preset_queries()
            print(Fore.BLUE + "Please select a preset query:")
            QueryPrompter.print_query_list(queries)
            query_choice = QueryPrompter.prompt_for_query_choice(queries)
            if query_choice is None:
                return
            query_index = query_choice - 1
            selected_query = queries[query_index]
            new_query = QueryPrompter.prompt_for_new_query(selected_query[0])
            if new_query is None:
                return
            QueryPrompter.update_query_in_list(queries, query_index, new_query)
            query_manager.update_query_in_database(selected_query[0], new_query)
        except Exception as e:
            logging.error("Failed to update query: %s", e)

    @staticmethod
    def prompt_for_query_choice(queries):
        """
        Prompt the user to select a query from the list.

        :param queries: A list of query tuples containing table names and query texts.
        :return: The index of the selected query, or None if no query was selected.
        """

        query_choice = prompt(
            Fore.CYAN + "Enter the number of the query to update (or 'q' to cancel): "
        )
        if query_choice.lower() == "q":
            return None
        return int(query_choice)

    @staticmethod
    def get_query_choices(queries):
        """
        Prompt the user to select multiple queries from the list.

        :param queries: A list of queries.
        :return: The selected queries.
        """
        print(Fore.CYAN + "Enter the numbers of the queries to run (separated by commas):")
        QueryPrompter.print_query_list(queries)
        query_choices = prompt("> ").split(",")
        return [queries[int(choice) - 1] for choice in query_choices]

    @staticmethod
    def prompt_for_new_query(query_name: Any) -> str | None:
        """
        Prompt the user to enter a new query.

        :param query_name: The name of the query to be updated.
        :return: The new query text, or None if no query was entered.
        """
        print(Fore.CYAN + f"Enter the new query for {query_name} (or 'q' to cancel):")
        new_query = prompt("> ")
        if new_query.lower() == "q":
            return None
        return new_query

    @staticmethod
    def get_custom_query(query_manager: QueryManager) -> tuple:
        """
        Prompt the user to enter a custom query.

        :param query_manager: An instance of the QueryManager class.
        :return: Custom query entry.
        """
        export_table_name = input(Fore.BLUE + "Enter the name of the table to export: ")
        query = input(Fore.LIGHTYELLOW_EX + "Enter the SQL query to export the table: ")

        save_query = input(Fore.BLUE + "Do you want to save this custom query for future use? [y/n]: ")
        if save_query.lower() == "y":
            # Save the query to the database
            query_manager.save_query_to_db(export_table_name, query)
            print(Fore.GREEN + "Custom query saved successfully!")

        return export_table_name, query

    @staticmethod
    def update_query_in_list(queries: list, query_index: int, new_query: str) -> None:
        """
        Update a query in the list of queries.

        :param queries: A list of query tuples containing table names and query texts.
        :param query_index: The index of the query to be updated.
        :param new_query: The new query text.
        :return: None
        """
        export_table_name, _ = queries[query_index]
        queries[query_index] = (export_table_name, new_query)
        print(Fore.GREEN + "Query updated successfully!")

    @staticmethod
    def print_query_list(queries: list) -> None:
        """
        Print a list of available queries.

        :param queries: A list of query tuples containing table names and query texts.
        :return: None
        """
        for i, (export_table_name, _) in enumerate(queries, start=1):
            print(Fore.CYAN + f"{i}. {export_table_name}")

    @staticmethod
    def get_preset_query_choice(queries: list) -> None:
        """
        Prompt the user to choose a preset query.

        :param queries: A list of query tuples containing table names and query texts.
        :return:
        """
        print(Fore.BLUE + "Please select a preset query:")
        for i, (export_table_name, query) in enumerate(queries, start=1):
            print(Fore.CYAN + f"{i}. {export_table_name}")

        while True:
            try:
                query_choice = int(input("Enter your choice: "))
                if 1 <= query_choice <= len(queries):
                    return queries[query_choice - 1]
                print(Fore.LIGHTRED_EX + "Invalid choice. Please enter a valid number.")
            except ValueError:
                print(Fore.LIGHTRED_EX + "Invalid input. Please enter a number.")

