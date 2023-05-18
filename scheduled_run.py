from colorama import Fore, Style

from scheduler.schedule_tasks import ExportScheduler


if __name__ == "__main__":
    print(Fore.YELLOW + "---------- WELCOME TO THE EXPORT SCHEDULING TOOL ----------\n" + Style.RESET_ALL)
    scheduler = ExportScheduler()
    scheduler.run()
