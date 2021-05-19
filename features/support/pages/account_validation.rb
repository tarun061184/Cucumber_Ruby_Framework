class AccountValidation
  include PageObject, PageObject::PageFactory

  page_url ENV['BASE_URL']

  #page objects:
  text_field(:preferred_name,       id: 'preferredName')
  text_field(:first_name,           id: 'firstName')
  text_field(:middle_name,          id: 'middleName')
  text_field(:last_name,            id: 'lastName')
  text_field(:phone,                id: 'primaryPhone')
  text_field(:secondary_phone,      id: 'alternatePhone')
  text_field(:email,                id: 'primaryEmail')
  text_field(:address,              id: 'permAddress')
  select_list(:state,               id: "state-select")
  text_field(:city,                 id: 'city')
  text_field(:zipcode,              id: 'zipCode')
  select_list(:military_status,     id: "military-status-select")
  select_list(:military_branch,     id: "military-branch-select")
  select_list(:military_rank,       id: "military-rank-select")
  text_field(:military_date,        id: 'DOSInputMask')
  text_field(:military_occupation,  id: 'primaryMilitaryOccupationSpecialty')
  text_field(:password,             id: 'passwordFrm')
  button(:submit,                   type: 'submit')

  # page methods:
  def fill_up_form(user)
    wait_until(timeout=60) { browser.ready_state.eql? 'complete' }
    user_data = YAML.load_file('features/config/data/form_data.yml')
    browser.element(css: 'fieldset.mt-4:nth-child(2)>div:nth-child(2)>div:nth-child(2)>app-sep-radiobutton:nth-child(1)>label:nth-child(1)>span').click
    puts "I have not attended Purdue Global or Kaplan University recently" #no return user selected
    self.preferred_name = user_data[user]['preferred_name']
    puts "I entered Preferred name as: #{preferred_name}"
    self.first_name = user_data[user]['first_name']
    puts "I entered First name as: #{first_name}"
    self.middle_name = user_data[user]['middle_name']
    puts "I entered Middle name as: #{middle_name}"
    self.last_name = user_data[user]['last_name']
    puts "I entered Last name as: #{last_name}"
    self.phone = user_data[user]['prim_phone']
    puts "I entered Phone as: #{phone}"
    self.secondary_phone = user_data[user]['sec_phone']
    puts "I entered Secondary Phone as: #{secondary_phone}"
    self.email = user_data[user]['email']
    puts "I entered Email as: #{email}"
    self.address = user_data[user]['address']
    puts "I entered Address as: #{address}"
    self.state = user_data[user]['state']
    puts "I entered State as: #{state}"
    self.city = user_data[user]['city']
    puts "I entered City as: #{city}"
    self.zipcode = user_data[user]['zip_code']
    puts "I entered Zip Code name as: #{zipcode}"
    puts "Country: United States of America"
    browser.element(css: "fieldset.mt-4:nth-child(5)>div:nth-child(2)>div:nth-child(1)>app-sep-radiobutton:nth-child(1)>label:nth-child(1)>span:nth-child(2)").click
    puts "I selected Military as: Yes"  # For military student
    self.military_status = user_data[user]['m1']
    puts "I entered Military Status as: #{military_status_element.text}"
    self.military_branch = user_data[user]['m2']
    puts "I entered Military Branch as: #{military_branch_element.text}"
    self.military_rank = user_data[user]['m3']
    puts "I entered Military Rank as: #{military_rank_element.text}"
    self.military_date = user_data[user]['m4']
    puts "I entered Military Date of Separation as: #{military_date}"
    self.military_occupation = user_data[user]['m5']
    puts "I entered Primary Military Occupational Specialty (MOS) as: #{military_occupation}"
    self.password = user_data[user]['pswd']
    puts "I set Password as: #{password}"
    browser.element(css: "div.pt-3:nth-child(1)>app-sep-checkbox:nth-child(1)>label:nth-child(1)").click
    puts "I agreed to the privacy policy"
  end

  def submit_form
    self.submit
    puts 'I click on submit button.'
  end

  def verify_submission
    if browser.element(css:'.modal-body>div:nth-child(1)>p:nth-child(1)').wait_until(timeout: 60, &:exists?)
      puts 'Existing Account - Test Pass'
    else
      raise 'Not an existing account - Test Fail'
    end
  end

end
