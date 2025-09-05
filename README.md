# My Website and Web Apps

This is a repository for my website and the web apps I have created while learning to program in Ruby, using a combination of a Classic and Modular Sinatra framework.

(Note: the code contains a lot of comments, which are my "study notes").

---

## Apps

**Port Charges Calculator**
This is a simple web app for customs brokers in Barbados to calculate Barbados Port Charges.

**Solar D Calculator**
A web app which tells you the current UV index of the sun and calculates, based on your age and skin type, the amount of time you would have to be outside with at least 25% of your body exposed to synthesize an optimum daily amount of vitamin D (1,000 IU). 

(Note: if testing the Solar D Calculator app in localhost, the IP-API will not be able to get a latitude and longitude based on the localhost IP address, as this is a loopback IP address which points to your own computer and doesn't represent a real goegraphical location. As a result, the OpenUV API will not be able to provide a UV index. So there is a fallback in place which, when testing the app in localhost, will provide the latitude and longitude of Barbados.)

**Encrypted Journal**

The above Port Charges Calculator and Solar D Calculator apps, as well as most of the website, are written using more of a classic Sinatra framework. However, the Encrypted Journal app which I started to build was written using a modular Sinatra framework. However, while building the app with a modular JournalController, I ran into persistent problems with getting ActiveRecord to recognize and connect to the local SQLite database. 

Running racksh or bundle exec puma resulted in errors:
- ActiveRecord::Base.connection.tables in racksh showed no database connected.
- Attempting to sign up/login to the Journal triggered "no database" errors. 

ActiveRecord uses the database.yml configuration to resolve the database path. However, in Sinatra, unlike Rails, the current working directory when running the app is not guarenteed to be the project root. Because my database.yml referenced a relative path like db/development.sqlite3, ActiveRecord would mis-resolve it to /absolute.

I attempted a fix by introducing an APP_ROOT constant, but I could not get it to work. 

**Ultimately, I have decided to continue working on my website and webapps using Rails since it provides a much more stable ActiveRecord + database integration.**

---

## How to run the code

If you want to try out the apps:

First, you will need to install ruby. You can do so by following [this guide](https://www.theodinproject.com/lessons/ruby-installing-ruby) by The Odin Project.

Next, you'll need to install sinatra and sinatra-reloader by running the following commands in your terminal:

```bash
gem install sinatra
```

```bash
gem install sinatra-reloader
```

Now create a parent directory for this repository to be cloned into. To do so, navigate to the parent directory in your terminal:

```bash
cd ~/your_parent_directory
```

Replacing "your_parent_directory" with whatever parent directory you have chose for this repository's directory.

Once you have navigated to your parent directory, run the following command:

```bash
git clone git@github.com:thomasridgeon/myrubyapps.git
```

Finally, in your terminal, navigate to the repository directory and run the following command:

```bash
bundle install
```

This will download and set up all the required libraries from the Gemfile.

Now you're ready to run the app in localhost. To do so, run the following command:

```bash
bundle exec puma
```

You can now open your browser and go to the link provided in your terminal.

To navigate to the Port Charges Calculator, use the /portcharges path, for example http://0.0.0.0:9292/portcharges

To navigate to the Solar D Calculator, use the /solardcalculator path. for example http://0.0.0.0:9292/solardcalculator 




