import logging
import sqlite3

from colorama import Fore
import mysql.connector as mysql
from prompt_toolkit import prompt
import psycopg2


class QueryManager:
    def __init__(self) -> None:
        # Create a connection pool to manage SQLite connections
        self.connection_pool = sqlite3.connect("./myapp/database/queries.db", check_same_thread=False)
        self.setup_database()
        self.setup_database_credentials()

    def setup_database(self) -> None:
        """
        Create queries and user_credentials in the sqlite database if they don't exit

        :return: None
        """
        # Create the queries table if it doesn't exist
        with self.connection_pool as conn:
            cursor = conn.cursor()

            # Create queries table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS queries (
                    id INTEGER PRIMARY KEY,
                    table_name TEXT,
                    query TEXT,
                    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # Create user_credentials table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS user_credentials (
                    host TEXT,
                    database TEXT,
                    port INTEGER,
                    username TEXT,
                    password TEXT,
                    engine TEXT
                )
            """)

    def save_query_to_db(self, table_name: str, query_text: str) -> None:
        """
        Save a query to the database.

        :param table_name: The name of the table associated with the query.
        :param query_text: The text of the query to be saved.
        :return: None
        """
        with self.connection_pool as conn:
            cursor = conn.cursor()
            query = "INSERT INTO queries (table_name, query) VALUES (?, ?)"
            values = (table_name, query_text)
            cursor.execute(query, values)

    def update_query_in_database(self, query_name: str, new_query: str):
        """
        Update a query in the database.

        :param query_name: The name of the query to be updated.
        :param new_query: The new query text.
        :return: Updates the query in the database
        """
        try:
            with self.connection_pool as conn:
                cursor = conn.cursor()
                update_query_sql = "UPDATE queries SET query = ? WHERE table_name = ?"
                values = (new_query, query_name)
                cursor.execute(update_query_sql, values)
        except sqlite3.Error as error:
            raise Exception("An error occurred while updating the query: " + str(error))

    def retrieve_preset_queries(self) -> list:
        """
        Retrieve the list of preset queries from the database.

        :return: A list of query tuples containing table names and query texts.
        """
        with self.connection_pool as conn:
            cursor = conn.cursor()
            select_query = "SELECT table_name, query FROM queries"
            cursor.execute(select_query)
            return cursor.fetchall()

    def store_credentials(self, host: str, database: str, port: str, username: str, password: str, engine: str) -> None:
        """
        Store the database credentials in the database.

        :param host: The database host
        :param database: The name of the database
        :param port: The port number
        :param username: The username
        :param password: The password
        :param engine: The database engine ("mysql" or "postgresql").
        :returns: None
        """
        with self.connection_pool as conn:
            cursor = conn.cursor()
            insert_query = "INSERT INTO user_credentials (host, database, port, username, password, engine) VALUES (" \
                           "?, ?, ?, ?, ?, ?)"
            values = (host, database, port, username, password, engine)
            cursor.execute(insert_query, values)

    def credentials_exist(self) -> bool:
        """
        Check if database credentials exist.

        :returns: True if credentials exist, False otherwise.
        """
        with self.connection_pool as conn:
            cursor = conn.cursor()
            select_query = "SELECT * FROM user_credentials"
            cursor.execute(select_query)
            return cursor.fetchone() is not None

    @staticmethod
    def test_mysql_connection(host: str, database: str, port: str, username: str, password: str) -> bool:
        """
        Test the database connection with the provided credentials.

        :param host: The database host
        :param database: The name of the database
        :param port: The port number
        :param username: The username
        :param password: The password

        :returns: True if the connection is successful, False otherwise.
        """
        try:
            with mysql.connect(
                host=host,
                port=port,
                user=username,
                password=password,
                db=database,
                connect_timeout=5
            ) as conn:
                return True
        except mysql.errors.DatabaseError as e:
            logging.error(f"Failed to connect to the database: {e}")
            return False

    @staticmethod
    def test_postgresql_connection(host: str, database: str, port: str, username: str, password: str):
        """
        Test the database connection with the provided credentials.

        :param host: The database host
        :param database: The name of the database
        :param port: The port number
        :param username: The username
        :param password: The password

        :returns: True if the connection is successful, False otherwise.
        """
        try:
            with psycopg2.connect(
                host=host,
                port=port,
                user=username,
                password=password,
                dbname=database,
                connect_timeout=5
            ) as conn:
                return True
        except psycopg2.DatabaseError as e:
            logging.error(f"Failed to connect to the PostgreSQL database: {e}")
            return False

    @staticmethod
    def select_database_engine() -> str:
        """
        Prompt the user to select the database engine.

        :returns: The selected database engine ("mysql" or "postgresql").
        """
        while True:
            engine = input(Fore.BLUE + "Select the database engine (1 - MySQL or 2 - PostgreSQL): ").lower()
            if engine == "1":
                return "mysql"
            elif engine == "2":
                return "postgresql"
            else:
                print(Fore.RED + "Invalid input. Please enter '1' or '2'.")

    @staticmethod
    def get_database_credentials() -> tuple:
        """
        Prompt the user to enter the database credentials.

        :returns: A tuple containing the host, database, port, username, and password.
        """
        host = input(Fore.CYAN + "HOST: ")
        database = input(Fore.CYAN + "DATABASE: ")
        port = int(input(Fore.CYAN + "PORT: "))
        username = input(Fore.CYAN + "USERNAME: ")
        password = prompt("PASSWORD: ", is_password=True)

        return host, database, port, username, password

    def setup_database_credentials(self) -> None:
        if self.credentials_exist():
            option = input(Fore.LIGHTBLUE_EX + "Enter '1' to create a new connection or '2' to connect to an existing "
                                               "username: ")
            if option == "1":
                self.create_new_connection()
            elif option == "2":
                self.connect_to_existing_username()
            else:
                print(Fore.RED + "Invalid option. Please try again.")
                return
        else:
            option = input(Fore.LIGHTBLUE_EX + "Enter '1' to create a new connection or press Enter to exit: ")
            if option == "1":
                self.create_new_connection()
            else:
                return

    def create_new_connection(self) -> None:
        engine_option = input(Fore.LIGHTBLUE_EX + "Enter '1' for MySQL or '2' for PostgreSQL: ")
        if engine_option == "1":
            engine = "mysql"
        elif engine_option == "2":
            engine = "postgresql"
        else:
            return

        host, database, port, username, password = self.get_database_credentials()
        self.store_credentials(host, database, port, username, password, engine)
        credentials = (host, database, port, username, password, engine)
        self.test_and_print_connection_status(credentials)

    def connect_to_existing_username(self) -> None:
        stored_usernames = self.retrieve_stored_usernames()
        selected_username = self.select_username(stored_usernames)
        credentials = self.retrieve_credentials_by_username(selected_username)
        self.test_and_print_connection_status(credentials)

    def test_and_print_connection_status(self, credentials: tuple) -> None:
        if credentials[5] == "mysql":
            if self.test_mysql_connection(*credentials[:5]):
                print(Fore.GREEN + "MySQL connection successful!")
            else:
                print(Fore.RED + "Failed to connect to the MySQL database. Please check your credentials.")
        elif credentials[5] == "postgresql":
            if self.test_postgresql_connection(*credentials[:5]):
                print(Fore.GREEN + "PostgreSQL connection successful!")
            else:
                print(Fore.RED + "Failed to connect to the PostgreSQL database. Please check your credentials.")

    def retrieve_stored_usernames(self) -> list:
        """
        Retrieve the list of stored usernames from the database.

        :return: A list of usernames.
        """
        with self.connection_pool as conn:
            cursor = conn.cursor()
            select_query = "SELECT username FROM user_credentials"
            cursor.execute(select_query)
            return [row[0] for row in cursor.fetchall()]

    @staticmethod
    def select_username(usernames: list) -> str:
        """
        Prompt the user to select a username from the provided list.

        :param usernames: A list of usernames.
        :return: The selected username.
        """
        print(Fore.LIGHTBLUE_EX + "Select a username:")
        for i, username in enumerate(usernames, start=1):
            print(Fore.LIGHTBLUE_EX, f"{i}. {username}")
        while True:
            selection = input(Fore.LIGHTBLUE_EX + "Enter the number corresponding to the username: ")
            if selection.isdigit() and int(selection) in range(1, len(usernames) + 1):
                return usernames[int(selection) - 1]
            else:
                print(Fore.LIGHTRED_EX + "Invalid input. Please enter a valid number.")

    def retrieve_credentials_by_username(self, username: str) -> tuple:
        """
        Retrieve the stored credentials by the username.

        :param username: The username.
        :return: A tuple containing the database credentials.
        """
        with self.connection_pool as conn:
            cursor = conn.cursor()
            select_query = "SELECT host, database, port, username, password, engine FROM user_credentials WHERE " \
                           "username = ?"
            cursor.execute(select_query, (username,))
            return cursor.fetchone()
