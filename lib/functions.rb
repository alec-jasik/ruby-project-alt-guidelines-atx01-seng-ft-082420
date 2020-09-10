def usertype
    choices = {patient: 1, doctor: 2}
    type = $prompt.select("Are you a patient or doctor?", choices)
 
    if type == 1
        patientinfo
    else
        doctorinfo
    end
end

def patientinfo
    patgreeting = $prompt.ask("We have a few questions about your personal info. 
    (Don't worry your information is safe with us, only you have access to it!)")
    patname = $prompt.ask("What is your name?")
    #patusername = $prompt.ask("Welcome, #{patname}. Please create a username:")
   # p "Username: #{patusername}"
   # patpassword = $prompt.mask("Please create a password:")
   # p "Password: #{patpassword}"
    patage = $prompt.ask("How old are you?")
    patweight = $prompt.ask("How much do you weigh?")
    patheight = $prompt.ask("How tall are you? (please specify in inches only)")

    Patient.create(name:patname, age: patage, weight: patweight, height:patheight) 
    
    
    puts "Thank you for the information, #{patname}. You are now registered in our data base as a patient! This is your Patient ID: #{Patient.last.id} 
    Please keep track of this number as it is very important! You will use it to manage your appointments!"
    mainoptions
end

def doctorinfo
    docgreeting = $prompt.ask("We have a few questions about your professional info. (Don't worry your information is safe with us, only you have access to it!)")
    docname = $prompt.ask("What is your name?")
    #docusername = $prompt.ask("Welcome, #{docname}. Please create a username:")
    # p "Username: #{docusername}"
    #docpassword = $prompt.mask("Please create a password:")
    #p "Password: #{docpassword}"
    docspecialty = $prompt.ask("What is your specialty?")
    doclocation = $prompt.ask("Where is your practice located? (Ex: 'City' NOTE: This is case sensitive")
    docyrs_experience = $prompt.ask("How many years of experience do you have in your profession?")

    Doctor.create(name: docname, specialty: docspecialty, location: doclocation, yrs_experience: docyrs_experience)

    puts "Thank you for the information, #{docname}! You are now registered in our data base as a doctor! This is your Doctor ID: #{Doctor.last.id}
    Please keep track of this number as it is very important! You will use it to manage your appointments!"
    mainoptions
end

def mainoptions
    choices = {"Schedule an appointment": 1, "Change an existing appointment": 2, "Cancel an appointment": 3, "More options": 4}
    option = $prompt.select("Please select what you would like to do:", choices)
        
    if option == 1
        createappointment
    elsif option ==2 
        editappointment
    elsif option == 3
        deleteappointment
    else 
        moreoptions
    end
end

def moreoptions
    choices = {"Check/Update any notes for a previous/upcoming appointment": 1, "See a list of Doctors": 2, "See a list of Patient histories": 3, "I would like to see the previous options": 4, "Im all done": 5}
    selection = $prompt.select("Please select what you would like to do:", choices)

    if selection == 1
        appnotes
    elsif selection == 2
        doctorlist
    elsif selection == 3
        patienthistories
    elsif selection == 4
        mainoptions
    else
        exitapplication
    end
end

def createappointment
    puts "Let's schedule a new appointment!"
    patid = $prompt.ask("Please enter Patient ID: (if you're a patient this will be your own ID or if youre a doctor, this will be the ID of the patient you are going to see)")
    docid = $prompt.ask("Please enter Doctor ID: (if you're a doctor this will be your own ID or if youre a patient, this will be the ID of the doctor you are going to see)")
    appdate = $prompt.ask("Please enter the date of the appointment you wish to schedule: (EX: to schedule for 08/01/2020, enter August 01 2020)")
    apptime = $prompt.ask("Please enter the date and time of the appointment you wish to schedule: (EX: to schedule for 08/01/2020 at 10:00, enter August 01 2020 10:00)")
    applocation = $prompt.ask("Please enter the location of the appointment: (City NOTE: This is case sensitive)")

    Appointment.create(doctor_id: docid, patient_id: patid, appointment_date: Date.parse(appdate), appointment_time: Time.parse(apptime), appointment_location: applocation)
    p "Your appointment has been scheduled! Your appointment ID is: #{Appointment.last.id}  Please keep track of this number as you will use it to manage this appointment!"
    mainoptions
end

def editappointment
    puts "Let's edit an existing appointment!"

    appid = $prompt.ask("Please enter the ID of the appointment you wish to change:")

    choices = {"Date": 1, "Time": 2, "Location": 3}
    selection = $prompt.select("Please select which parameter of the appointment you would like to change:", choices)

    if selection ==1 
        newappdate = $prompt.ask("Please enter the date you wish to change the appointment to: (EX: to schedule for 08/01/2020, enter August 01 2020)")
        originalappdate = Appointment.find_by(id: appid)
        originalappdate.update(appointment_date: Date.parse(newappdate))
        puts "Confirmation: Your appointment date has been updated to: #{newappdate}."
        mainoptions
    elsif selection == 2
        newapptime = $prompt.ask("Please enter the time you wish to change the appointment to: (EX: to schedule for 08/01/2020 10:00, enter August 01 2020 10:00)")
        originalapptime = Appointment.find_by(id: appid)
        originalapptime.update(appointment_time: Time.parse(newapptime))
        puts "Confirmation: Your appointment time has been updated to: #{newapptime}."
        mainoptions
    else
        newapplocation = $prompt.ask("Please enter the location you wish to change the appointment to: (City NOTE: This is case sensitive)")
        originalapplocation = Appointment.find_by(id: appid)
        originalapplocation.update(appointment_location: newapplocation)
        puts "Confirmation: Your appointment location has been updated to: #{newapplocation}."
        mainoptions
    end
end

def deleteappointment
    puts "Let's cancel an appointment!"

    appid = $prompt.ask("Please enter the ID of the appointment you wish to cancel:")

    originalapp = Appointment.find_by(id: appid)
    originalapp.destroy

    puts "Confirmation: Your appointment has been canceled."
    mainoptions
end

def appnotes
    appid = $prompt.ask("Please give the ID of the appointment you are referencing:")

    choices = {"Read appointment note": 1, "Update appointment note": 2}
    option = $prompt.select("Would you like to read this appointment note or update this appointment note:", choices)

    if option == 1
        appnote = Appointment_Note.find_by(appointment_id: appid).note
        p appnote
        mainoptions
    else
        newnote = $prompt.ask("Please specify what you would like the updated note to read:")
        oldnote = Appointment_Note.find_by(appointment_id: appid)
        oldnote.update(note: newnote.to_s)

        puts "Confirmation: Your appointment note has been updated."
        mainoptions
    end
end

def doctorlist
    choices = {"All doctors": 1, "By name": 2, "By specialty": 3, "By Location": 4, "By experience": 5}
    option = $prompt.select("How would you like to search for your list of doctors:", choices)

    if option == 1
        ap Doctor.all
        mainoptions
    elsif option == 2
        docname = $prompt.ask("Please specify the name of the docotor you wish to search for: (Note this is case sensitive, Ex:  use 'Joe Smith' not 'joe smith')")
        ap Doctor.where(name: docname)
        mainoptions
    elsif option == 3
        docspecialty = $prompt.ask("Please specify the specialty of the doctor you wish to search for: (Note this is case sensitive, Ex:  use 'Physical Therapy' not 'physical therapy')")
        ap Doctor.where(specialty: docspecialty)
        mainoptions
    elsif option == 4
        doclocation = $prompt.ask("Please specify the city of the docotor you wish to search for: (Note this is case sensitive, Ex: use 'Houston' not 'houston')")
        ap Doctor.where(location: doclocation)
        mainoptions
    else
        docexperience = $prompt.ask("Please specify the number of years of experience you wish for the doctor to have: (Please use only whole numbers, decimals/fractions are not allowed)")
        ap Doctor.where(yrs_experience: docexperience)
        mainoptions
    end
end

def patienthistories
    patid = $prompt.ask("Please privde the patient ID you wish to inquire about:")
    Patient_History.where(patient_id: patid)
    mainoptions
end