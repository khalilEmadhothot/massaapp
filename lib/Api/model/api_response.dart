class ApiResponse<T> {
  late String description;
  late bool success;
  List<T>? data;


  ApiResponse({
    required this.description,
    required this.success,
  });
  ApiResponse.listResponse({
    required this.description,
    required this.success,
    required this.data,
  });


}
