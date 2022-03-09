class UserModel {
  String? id, email, phoneNumber, password, role, businessName, currentAddress;
  bool? isVerified;

  String? fullName, profilePhoto;
  UserModel(
      {this.id,
      this.email,
      this.phoneNumber,
      this.profilePhoto,
      this.password,
      this.role,
      this.isVerified,
      this.fullName,
      this.currentAddress,
      this.businessName});
}
