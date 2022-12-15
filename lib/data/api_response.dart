enum Status { LOADING, COMPLETED, ERROR }

class ApiResponse<T> {
  Status status;

  late T data;
  late String message;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status $status Message $message Data $data";
  }
}
