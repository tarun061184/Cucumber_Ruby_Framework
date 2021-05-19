Given 'I am on Step1 page' do
  visit(AccountValidation)
end

When 'I fill up the form for {string}' do |user|
  on(AccountValidation).fill_up_form(user)
end

And 'I Submit the form' do
  on(AccountValidation).submit_form
end

Then 'I should see account already exists message' do
  on(AccountValidation).verify_submission
  @browser.screenshot.save("results/screenshots/account_exists.png")
end
