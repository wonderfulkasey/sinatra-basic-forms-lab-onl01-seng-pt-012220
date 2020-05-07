require 'pry'
describe App do

  describe 'GET /' do

    it 'sends a 200 status code' do
      get '/'
      expect(last_response.status).to eq(200)
    end

    it 'has a link with the text "List A Puppy"' do
      visit '/'
      expect(page).to have_link("List A Puppy")
    end

    it 'has a link to list a puppy that links to /new' do
      visit '/'
      expect(page).to have_link("List A Puppy", href: '/new')
    end
  end

  describe 'GET /new' do
    it 'sends a 200 status code' do
      get '/new'
      expect(last_response.status).to eq(200)
    end

    it 'renders a form that can POST a name, breed, and age' do
      visit '/new'

      expect(page).to have_selector("form")

      #form method attribute is a post
      expect(page.find('form')[:method]).to match(/post/i)

      expect(page).to have_field(:name)
      expect(page).to have_field(:breed)
      expect(page).to have_field(:age)
    end
  end

  describe 'POST /puppy' do

    before(:all) do
      visit '/new'

      fill_in(:name, :with => "Butch")
      fill_in(:breed, :with => "Mastiff")
      fill_in(:age, :with => "6")

      #the below css will match any element (input or button)
      #with a type attribute set to submit
      page.find(:css, '[type=submit]').click
    end

    it "sends a 200 status code" do
      expect(page.status_code).to eq(200)
    end

    it "recieves a request from /new at /puppy" do
      expect(page.current_path).to eq("/puppy")
    end

  #
  end

end
