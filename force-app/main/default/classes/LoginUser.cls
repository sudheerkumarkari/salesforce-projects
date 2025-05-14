global class LoginUser {
    @AuraEnabled
    global static String login(String userName, String password) {
        String homeURL = 'https://dxc159-dev-ed.my.site.com/S/';
        ApexPages.PageReference pageRef = Site.login(userName, password, homeURL);

        if (pageRef != null) {
            return pageRef.getUrl(); // Success
        } else {
            return 'ERROR'; // Login failed
        }
    }
}
