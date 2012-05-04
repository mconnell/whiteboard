# Whiteboard


## Background Jobs

This app uses delayed job to run background processes.

In development:

    rake jobs:work

In production:

    RAILS_ENV=production script/delayed_job start
