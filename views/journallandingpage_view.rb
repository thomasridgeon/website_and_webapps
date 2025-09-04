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

      body(class: 'flex items-center justify-center min-h-screen p-4') do
        # parent container
        div(class: 'w-full max-w-md bg-white p-6 rounded-lg shadow-md') do
          h1(class: 'text-2xl sm:text-3xl font-bold mb-6 text-center text-black') { text 'Encrypted Journal' }
          p(class: 'text-lg sm:text-2xl font-semibold mb-6 text-center text-black') do
            text 'Sign up or log in to get started with creating and managing your notes securely'
          end
          a(href: '/journal/signup',
            class: 'text-base sm:text-lg font-semibold mb-6 text-center text-blue-400 underline') do
            text 'Sign Up'
          end
          br
          a(href: '/journal/login',
            class: 'text-base sm:text-lg font-semibold mb-6 text-center text-blue-400 underline') do
            text 'Log In'
          end
        end
      end
    end
  end
end
