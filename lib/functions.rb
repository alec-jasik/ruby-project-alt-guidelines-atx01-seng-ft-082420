def patientinfo
    patgreeting = $prompt.ask("We have a few questions about your personal info. 
    (Don't worry your information is safe with us, only you have access to it!)")
    patname = $prompt.ask("What is your name?")
    patusername = $prompt.ask("Welcome, #{patname}. Please create a username:")
    p "Username: #{patusername}"
    patpassword = $prompt.mask("Please create a password:")
    p "Password: #{patpassword}"
    patage = $prompt.ask("How old are you?")
    patweight = $prompt.ask("How much do you weigh?")
    patheight = $prompt.ask("How tall are you? (please specify in inches only)")

    #create an instance of this patient from the info provided above
end

def doctorinfo
    docgreeting = $prompt.ask("We have a few questions about your professional info. 
    (Don't worry your information is safe with us, only you have access to it!)")
    docname = $prompt.ask("What is your name?")
    docusername = $prompt.ask("Welcome, #{docname}. Please create a username:")
    p "Username: #{docusername}"
    docpassword = $prompt.mask("Please create a password:")
    p "Password: #{docpassword}"
    docspecialty = $prompt.ask("What is your specialty?")
    doclocation = $prompt.ask("Where is your practice located?")
    docyrs_experience = $prompt.ask("How many years of experience do you have in your proffesion?")
         #create an instance of this doctor from the info provided above
end

def usertype
    choices = {patient: 1, doctor: 2}
 type = $prompt.select("Are you a patient or doctor?", choices)
 
    if type == 1
        patientinfo
    else
        doctorinfo
    end
end

