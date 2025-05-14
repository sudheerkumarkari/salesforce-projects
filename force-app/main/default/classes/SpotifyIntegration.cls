public with sharing class SpotifyIntegration {

    @AuraEnabled
    public static String searchWithSpotify(String trackName) {
        // Create the instance of HTTP Class
        Http http = new Http();

        // Create the instance of HTTPRequest Class
        HttpRequest request = new HttpRequest();

        // Populate the attributes of Request
        request.setMethod('GET');

        String encodedName = EncodingUtil.urlEncode(trackName, 'UTF-8');

        // Construct the API endpoint for search
        request.setEndpoint('callout:Spotify/v1/search?q=' + encodedName + '&type=track&limit=1&offset=1');

        // Send the request and process the response
        try {
            HttpResponse response = http.send(request);
            System.debug('Response: ' + response.getBody());
            System.debug('Response Status Code: ' + response.getStatusCode());
            System.debug('Response Status: ' + response.getStatus());
            return response.getBody();
        } catch (Exception e) {
            System.debug('Callout error: ' + e.getMessage());
            return null;
        }
    }

    @AuraEnabled
    public static String getAccessToken() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setEndpoint('callout:Spotify/token');

        // Setting required headers
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization', 'Basic YOUR_CLIENT_CREDENTIALS');

        // Sending request and parsing response
        try {
            HttpResponse response = http.send(request);
            System.debug('Access Token Response: ' + response.getBody());
            return response.getBody();
        } catch (Exception e) {
            System.debug('Token Request Error: ' + e.getMessage());
            return null;
        }
    }
}