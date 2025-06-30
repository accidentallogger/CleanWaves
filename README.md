

Home page
 - upcoming cleanup events - will be a map with points 
 - community posts
 - news

Cleanup tab
 - has posts about events that took place 
 - it also has a floating button at bottom right + showing add event which opens a separate page for event form 
- has date, time, place, ongoing/upcoming/ended
 - when clicked on posts, it will lead to a page with details of the event, banner on top, below that it has date,time from to end, place, ongoing/upcoming/ended, then it will have the name of the organizer with its profile pic, a short description of the event, below that event stats, such as volunteer count attending/capacity, hours planned, waste target in kgs

 - a button for the user to click called participate 
 - below that actions area will have two buttons share and get directions
 - share will generate the url of the event page and a small writeup which can be readily sent to any app in the mobile system.
 - for now keep directions just a button
 - if the user is admin on the event page then they should be able to view the manage event button which will lead to a page with 4 tabs on top each leading to separate section, waste, volunteers, alert, edit event.
 - in waste there should be a list where we can add waste types that have been collected along with that we can add the kgs of weight, another feild where we can input recyclable waste weight.

- add before after photo.

- volunteers section will have a status bar showing how many volunteers have checked in
- there will be a checkin qr code generated for the event.
- then list of volunteers with simultaneous tags showcasing checkedin, not checkedin. status
- Alert section has option to send push notification with some text to all users in that event. for now just make the frontend.
- and then a section the percentage of each type of data.
- edit event we can edit details of the event as admin.


Learning hub
- it has options for quizzes, case studies and learning modules like 3 buttons on the page along with that we have a ecobot which is a circular avatar and after clickingon it it opens the ai mascot that we made before with a chat box and the tts and speech to text capabilities.

Profile
- avatar image with name, rank, score below that there is waste collected hours volunteered and rewards achieved like badges unlocked and mascot skin.









API CALLS:

    homepage: 
    GET /events/ → Get list of upcoming,ongoing and past events for the map in key value pairs should have LAT AND LONG VALUES IN DOUBLE.

    GET /community/posts → Get community posts

    GET /news → Get news updates

    
    cleanup area page:
    
    GET /events → List all events

    GET /events/:id → Get details of a specific event

    POST /events → Create a new event

    PUT /events/:id → Edit event (if admin previleges granted in event.)

    DELETE /events/:id → Delete event (optional)
    
    GET /events/adminlist → enlist admins

    POST /events/:id/participate → Join/participate in event 

    GET /events/:id/participants → Get participant list

    POST /events/:id/checkin → Check-in volunteer (with QR or GPS)

    POST /events/:id/waste → Submit waste data (type, kg, recyclable kg)

    POST /events/:id/photos → Upload before/after photos

    POST /events/:id/alerts → push notifs and emails 
    
    GET /events/reviews → get public reviews from other users.

    POST /events/send-reviews → one event ends users can write their thoughts and reviews.

Analytics
    GET /analytics/event/:id → Event-level stats (waste, volunteer hours, basically all data except for the trivial ones like area name etc)

    GET /analytics/user/:id → just send amount of events user has taken part in or amount of waste that is cleaned by him
    
Volunteers
    GET /volunteers → List volunteers (admin)

    GET /volunteers/:id → Get volunteer profile
    
    POST /markpresent/<custom string in qr code>

Map / Geospatial
    GET /heatmap/live → Live heatmap points during event  dict of where individual parts have lat, long and intensity-> need logic to calculate intensity according tot he gps data of users on the backend in event.

    GET /events/:id/regions → Get boundary points marked by user on the map while marking area for event. saved as lat long pairs in an array. 

    POST events/:id/regions → Mark region boundary for event. User sends list of lat long points in array.

GET /quizzes → Quiz list

GET /quiz/:id → Quiz details

POST /quiz/:id/submit → Submit quiz answer

GET /case-studies → Case study list

GET /case-study/:id → Case study details


GET /user/:id → User profile

GET /user/:id/badges → Badges/unlocks

GET /user/:id/rewards → Rewards / mascot skins


rest are LLM features like mascot reply system and waste detection and achievement mechanic

    
    
    


    