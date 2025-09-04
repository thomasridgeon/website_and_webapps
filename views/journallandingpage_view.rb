require 'erector'

class JournalLandingPage < Erector::Widget
  def content
    html do
      head do
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')
        title 'Login'

        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        link(rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css')
        link(href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap',
             rel: 'stylesheet')

        style do
          rawtext <<-CSS
      html, body {
        font-family: 'Montserrat', sans-serif !important;
      }
          CSS
        end
      end

      body(class: 'bg-white text-black') do
        div(class: 'w-full md:max-w-2xl p-4 md:p-6 pt-16 md:pt-0 flex flex-col items-start mx-4 md:ml-20') do
          div(class: 'max-w-prose w-full') do
            h1(class: 'text-5xl md:text-7xl font-bold mt-10 md:mt-28 mb-10 text-left') do # h1 only needs a bottom margin to space itself from the paragraphs below.
              text 'Welcome to my encrypted journal app!'
            end
            p(class: 'text-2xl md:text-5xl font-semibold mb-8 text-left') do
              text 'Sign up to get started with creating and managing your notes securely'
            end
            a(href: '/journal/signup', class: 'text-lg md:text-2xl font-bold mb-8 text-left') { text 'Sign Up' }
            a(href: '/journal/login', class: 'text-lg md:text-2xl font-bold mb-8 text-left') { text 'Log In' }
          end
        end
      end
    end
  end
end
