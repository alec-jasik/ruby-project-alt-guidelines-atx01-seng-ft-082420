$prompt = TTY::Prompt.new

def startup
    p "Welcome to APPointment Lite"
    usertype
end

def exitapplication
    choices = {"Yes, I'm sure": 1, "No, I'm not finished yet": 2}
    option = $prompt.select("Are you sure you would like to exit the application?:", choices)

    if option == 1
        p "Thank you for using APPointment Lite. We hope to see you again!"
    else
        mainoptions
    end
end
