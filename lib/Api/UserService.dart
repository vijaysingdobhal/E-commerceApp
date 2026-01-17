import 'package:ecommerceapp/Model/User.dart';

class UserService {
  User getMockUser() {
    return User(
      name: 'Syed Noman',
      email: 'syed.noman@example.com',
      avatarUrl: 'https://via.placeholder.com/150',
    );
  }
}
