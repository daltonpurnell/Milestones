
// Use Parse.Cloud.define to define as many cloud functions as you want.
Parse.Cloud.define("searchForPendingInvites", function(request, response) {
    
    Parse.Cloud.useMasterKey();
    var Invite = Parse.Object.extend("Invite");
    var emailAddress = request.params.emailAddress;
    
//        inviteRecipientToSignUp.save(null, {
//            success: function(invite) {
                        var recipientUsername = request.params.emailAddress;
                                     console.log(recipientUsername);
                        if (recipientUsername) {
                                     
                                     var pushQuery = new Parse.Query(Invite);
                                     pushQuery.equalTo("emailAddress", recipientUsername);
                                     pushQuery.includeKey("scrapbook.entries");
                                     pushQuery.find({
                                                    success: function(invitesArray) {
                                                    console.log(invitesArray);
                                                    // for loop through invite array
                                                    for (Invite in invitesArray) {
                                                    // update acl for scrapbooks and entries
                                                        var updatedACL = invite.ACL();
                                                        updatedACL.setWriteAccess(request.user["recipientUsername"].toString(),true);
                                                                for (entry in scrapbook.entries)
                                                                var updatedACL = entry.ACL();
                                                                updatedACL.setWriteAccess(request.user["recipientUsername"].toString(),true);
                                                    
                                                    },
                                                    error: function(error) {
                                                    response.error(error);
                                                    console.error(error);
                                                    }
                                                    });
        
        
    }
    
}