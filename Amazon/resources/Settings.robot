*** Settings ***
Documentation    A resource for global
Library          Selenium2Library                15    run_on_failure=Log Source
Library          String
Library          Dialogs
Library          FakerLibrary
Library          XvfbRobot
Library          DebugLibrary
Library          DateTime
Library          HttpLibrary.HTTP
#Library         ../../utils/CustomLibrary.py