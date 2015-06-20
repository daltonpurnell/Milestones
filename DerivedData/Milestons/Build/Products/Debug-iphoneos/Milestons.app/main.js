
// Use Parse.Cloud.define to define as many cloud functions as you want.
Parse.Cloud.define("updateInviteForAcceptedResponse", function(request, response) {
    
    Parse.Cloud.useMasterKey();
    var Invite = Parse.Object.extend("Invite");
    var emailAddress = request.params.emailAddress;
    
        inviteRecipientToSignUp.save(null, {
            success: function(invite) {
                        var recipientUsernames = request.params.emailAddress;
                        if (recipientUsernames.length > 0) {
                                     
                                     var pushQuery = new Parse.Query(Invite);
                                     pushQuery.equalTo("accountSetup",
                                     pushQuery.containedIn("objectId", emailAddress);
                                        
        
        
    }
    
}