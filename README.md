# Votr

Super simple proposal voting inspired by Vestibule.

To get this thing running you'll need;

- Foreman & Procfile
- A `.env` file with the following in:

``TWITTER_KEY=``
``TWITTER_SECRET=``
``AUTH_PASSWORD=some admin password``

The Twitter bits are used for auth and the password is used for the (super simple) admin area. There are a few bits and pieces that are hard coded (like dates). Lots of this could be nicer, but I just wanted to get something built for now.

Feel free to PR this sucka.
