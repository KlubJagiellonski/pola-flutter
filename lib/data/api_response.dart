enum Status { loading, completed, error }

class ApiResponse<T> {
  Status status;

  late T data;
  late String message;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status $status Message $message Data $data";
  }
}
