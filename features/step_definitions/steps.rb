Given(/^there is a deputy$/) do
  @deputy = Deputy.make!
end

Given(/^this deputy held a refund of (\d+) for "(.*?)" last month$/) do |arg1, arg2|
  Refund.make! deputy: @deputy, company: Company.make!(name: arg2), value: arg1
end

When(/^I am in "(.*?)"$/) do |arg1|
  visit route_to_path(arg1)
end

Then(/^I should see this deputy$/) do
  page.should have_css(".deputy .nickname", text: @deputy.nickname)
end

Then(/^the most suspicious company of this deputy should be "(.*?)"$/) do |arg1|
  page.should have_css(".deputy[data-id='#{@deputy.id}'] .suspicious_company .company_name", text: arg1)
end
