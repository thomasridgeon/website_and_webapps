# My Website and Web Apps

This is the repository for my expanded upon website and web apps, as I continued my journey learning to program in Ruby. This time I am using a hybrid Sinatra setup. Static web pages and my first two web apps, which were quite simple, were written in classic Sinatra style. While the third web app I started- which was a bit more complex in that it had to handle authentication and database interactions- was written in a modular style. 

With regard to my static web pages and the two simple web apps, for each page/app I have a controller file with routes and logic and a corresponding view file with an Erector widget to render the html and Tailwind CSS. These pages/apps operate in the context of Sinatra::Application, which is a Sinatra::Base subclass that Sinatra defines automatically as the default. 

Because my third app required user authentication, database-backed models, storage with multiple routes and session handing, I chose the modular approach, defining my own Sinatra::Base subclass and telling Rack to mount it using Rack::URLMap. That way, this app could be isolated from my other pages/apps and have its own configuration, allowing it to scale as its own mini-app. As I explain below in the description for this app, I ultimately ran into trouble with this approach and migrated my entire project to Rails. 

(Note: the code contains a lot of comments, which are my "study notes").

---

## Apps

**Port Charges Calculator**
This is a simple web app for customs brokers in Barbados to calculate Barbados Port Charges.

**Solar D Calculator**
A web app which tells you the current UV index of the sun and calculates, based on your age and skin type, the amount of time you would have to be outside with at least 25% of your body exposed to synthesize an optimum daily amount of vitamin D (1,000 IU). 

(Note: if testing the Solar D Calculator app in localhost, the IP-API will not be able to get a latitude and longitude based on the localhost IP address, as this is a loopback IP address which points to your own computer and doesn't represent a real goegraphical location. As a result, the OpenUV API will not be able to provide a UV index. So there is a fallback in place which, when testing the app in localhost, will provide the latitude and longitude of Barbados.)

**Encrypted Journal**

The above Port Charges Calculator and Solar D Calculator apps, as well as most of the website, are written in a classic Sinatra style. However, I chose to start writing my Encrypted Journal app using a modeular sytle, as it would have to handle authentication and database interaction. However, while building the app with a modular JournalController, I ran into persistent problems with getting ActiveRecord to recognize and connect to the local SQLite database. 

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

The Encrypted Journal App was not finished and therefore cannot be tried. For this, please see the latest version of my project which has now migrated to Rails. 



