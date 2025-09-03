require 'erector'

class LoginPage < Erector::Widget
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
        div(class: 'w-full max-w-md bg-white p-6 rounded-lg shadow-md') do
          h2(class: 'text-2xl sm:text-3xl font-bold mb-6 text-center text-black') { text 'Login' }

          form(action: '/journal/login', method: 'post', class: 'space-y-4') do
            # Username
            div do
              label(for: 'username', class: 'block mb-1 font-medium') { text 'Username' }
              input(type: 'text', name: 'username', id: 'username',
                    class: 'border rounded w-full p-2 focus:outline-none focus:ring-2 focus:ring-blue-400')
            end
            # Password
            div do
              label(for: 'password', class: 'block mb-1 font-medium') { text 'Password' }
              input(type: 'password', name: 'password', id: 'password',
                    class: 'border rounded w-full p-2 focus:outline-none focus:ring-2 focus:ring-blue-400')
            end
            # Submit button
            div do
              input(type: 'submit', value: 'Login',
                    class: 'bg-blue-500 text-white font-semibold px-4 py-2 rounded w-full sm:w-auto hover:bg-blue-600 cursor-pointer')
            end
          end
        end
      end
    end
  end
end
