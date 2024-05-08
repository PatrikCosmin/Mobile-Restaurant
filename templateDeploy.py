import os

def create_folder_structure():
    folders = [
        'lib',
        'lib/screens',
        'lib/widgets',
        'lib/models',
        'lib/services',
        'lib/utils'
    ]
    for folder in folders:
        os.makedirs(folder, exist_ok=True)

def create_files():
    files = [
        'lib/main.dart',
        'lib/screens/home_screen.dart',
        'lib/screens/menu_screen.dart',
        'lib/screens/reservation_screen.dart',
        'lib/screens/about_screen.dart',
        'lib/screens/contact_screen.dart',
        'lib/screens/feedback_screen.dart',
        'lib/screens/users_screen.dart',
        'lib/screens/login_screen.dart',
        'lib/screens/register_screen.dart',
        'lib/screens/edit_menu_item_screen.dart',
        'lib/screens/edit_reservation_screen.dart',
        'lib/screens/edit_user_screen.dart',
        'lib/screens/edit_feedback_screen.dart',
        'lib/widgets/drawer.dart',
        'lib/widgets/menu_item_card.dart',
        'lib/widgets/reservation_card.dart',
        'lib/widgets/feedback_card.dart',
        'lib/models/menu_item.dart',
        'lib/models/reservation.dart',
        'lib/models/feedback.dart',
        'lib/models/user.dart',
        'lib/services/api_service.dart',
        'lib/utils/constants.dart'
    ]
    for file in files:
        open(file, 'a').close()

def main():
    create_folder_structure()
    create_files()

if __name__ == "__main__":
    main()
