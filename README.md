Github repo: https://github.com/lohikansun/microblog
Deployed Application: microblog.hmmmmmmm.com

<strong> Login </strong>
Users can login using the text input box and log in button found in the navbar. Login can occur from any page. At this point only a registered email address is needed for login. User will remain logged in until they click logout in the navbar. The current user is stored in the session.

<strong> Post </strong>
Users who are logged in can post a new message from the message index page using the "New Message" button. The button will bring them to a form where they can enter the post text and click submit. After submitting, they are brought to the show page for the message, displaying the post, their username, and the time the message was posted. This message will then be added to the message index list, as well as in the list of messages in the user's show page.

<strong> Follow </strong>
Users who are logged in can follow other users by clicking the "Follow" button for a different user on the Users index page. Following the user will add that user's email to the "Following" section on the current user's show page. Users can also click "Unfollow" on followed users on the User show page to reverse this effect.

<strong> Like </strong>
From the show page of a message, logged in users can click the "Like" button to like a message. Clicking the button will add their emails to the list of likes for the message. Once liked, the button will change to "Unlike". Click the button will remove the user's email from the list of likes. The list of likes is public and visible to anyone viewing the show page of a message.

<strong>Deploy script</strong>
The deploy script found in this repository can be used to automatically release the current version of the microblog application. The script must be run from a checked out git release on the production server. It takes no arguments and will automatically build and deploy the release, and start the application upon success.
