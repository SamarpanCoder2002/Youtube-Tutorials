class API {
  static const baseUrl = 'https://second-service.onrender.com/api';

  static const getApiEndPoint = '$baseUrl/hello';
  static String postApiEndPoint(String param,
          {required String category,
          required String topic,
          required String lang}) =>
      '$baseUrl/send-data/$param?cat=$category&topic=$topic&lang=$lang';
  static const putApiEndPoint = '$baseUrl/update-data/ok@2023';
  static const deleteApiEndPoint = '$baseUrl/delete-data/ok@2023';
}
