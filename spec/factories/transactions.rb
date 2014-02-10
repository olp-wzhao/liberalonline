FactoryGirl.define do
  factory :transaction do
    prefix "Mr."
    first_name "Jesse"
    last_name "Naiman"
    street_address "44 Mentor Blvd    " 
    postal_code "M4Y2V6"
    city "Toronto" 
    telephone "4165555555" 
    email "jnaiman@rspec.ca" 
    card_name "Test Account" 
    card_security "345" 
    card_expiry  Date.parse('1970-01-01')
    card_reference "......0431" 
    card_type "MC" 
    personal 0.0 
    company_name nil 
    user_ip "192.168.1.1" 
    origin_url "/Tracking/t.c" 
    target_url "https://contribute.ontarioliberal.ca/Home/Donate?promo-code=Day15MoroccoYeungRaccoEN1" 
    promo_code nil 
    gateway_response "<Result>\r\n  <TransTime>Wed Jan 29 14:44:11 EST 2014</TransTime>\r\n  <OrderID>2014012914440900257</OrderID>\r\n  <TransactionType>SALE</TransactionType>\r\n  <Approved>APPROVED</Approved>\r\n  <ReturnCode>Y:14441Z:1df2541:M:W:YNN</ReturnCode>\r\n  <ErrMsg></ErrMsg>\r\n  <TaxTotal>0.00</TaxTotal>\r\n  <ShipTotal>0.00</ShipTotal>\r\n  <SubTotal>20.00</SubTotal>\r\n  <FullTotal>20.00</FullTotal>\r\n  <PaymentType>CC</PaymentType>\r\n  <CardNumber>......0181</CardNumber>\r\n  <TransRefNumber>1bf33613324c8ea1</TransRefNumber>\r\n  <CardIDResult>M</CardIDResult>\r\n  <AVSResult>W</AVSResult>\r\n  <CardAuthNumber>14441Z</CardAuthNumber>\r\n  <CardRefNumber>1df2541</CardRefNumber>\r\n  <CardType>MC</CardType>\r\n  <IPResult>YNN</IPResult>\r\n  <IPCountry>CA</IPCountry>\r\n  <IPRegion>Quebec</IPRegion>\r\n  <IPCity>Sherbrooke</IPCity>\r\n</Result>"
    home_riding 0.0 
    type "Donation" 
    comments "Central" 
    complete 0.0 
    sequence :reference do |n|
        "2014012914440900257#{n}"
    end 
    sequence :temp_id do |n|
        28712 + n
    end
    success nil
    #user
  end
end