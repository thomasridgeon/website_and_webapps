#---Home Page Widget----------------------------
require 'erector'

class HomePage < Erector::Widget
  # defines a new class HomePage which inherits from the superclass Erector::Widget. :: signifies that the Widget class lives inside the Erector module.
  # So because of inheritance, the HomePage is an Erector::Widget, and therefore gets all the methods and functionality of Erector::Widget.

  def content
    rawtext '<!DOCTYPE html>'
    # By including <!DOCTYPE html>, you ensure the browser uses the latest and most consistent rendering rules for modern HTML.
    html do
      head do
        title 'Home Page'
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')

        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        link(rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css')
        link(href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap',
             rel: 'stylesheet')

        # CSS code to add custom font
        style do
          rawtext <<-CSS
            html, body {
              font-family: 'Montserrat', sans-serif !important;
            }
          CSS
        end
      end # closes head do

      body(class: 'bg-white text-black') do
        #---Nav bar---
        nav(class: 'bg-black text-white font-semibold w-full px-6 py-4 flex justify-between items-center fixed top-0 left-0 right-0 shadow-md z-50') do
          # Left Side
          div do
            a(href: '/', class: 'text-lg hover:text-gray-300 transition-colors') do
              text 'Home'
            end
          end

          # Hamburger button (mobile only)
          button(
            class: 'md:hidden focus:outline-none',
            onclick: "document.getElementById('mobile-menu').classList.toggle('hidden')"
          ) do
            # SVG icon (hamburger lines)
            rawtext <<-SVG
              <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            SVG
          end

          # Right Side (desktop menu only)
          div(class: 'hidden md:flex space-x-6') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
            a(href: '/resume', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Resume' }
          end
        end

        # Mobile menu (hidden by default)
        div(id: 'mobile-menu',
            class: 'hidden md:hidden bg-black text-white w-full fixed top-16 left-0 right-0 z-40 px-6 py-4') do
          div(class: 'flex flex-col space-y-4 text-center') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
            a(href: '/resume', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Resume' }
          end
        end
        #----------------

        #---Main content-----

        div(class: 'w-full md:max-w-2xl p-4 md:p-6 pt-16 md:pt-0 flex flex-col items-start mx-4 md:ml-20') do
          div(class: 'max-w-prose w-full') do
            h1(class: 'text-5xl md:text-7xl font-bold mt-10 md:mt-28 mb-10 text-left') do # h1 only needs a bottom margin to space itself from the paragraphs below.
              text 'Hey!'
            end
            p(class: 'text-2xl md:text-5xl font-semibold mb-8 text-left') do
              text 'My name is Thomas Ridgeon'
            end
            p(class: 'text-base sm:text-lg mb-4 text-left') do
              text 'This is my website where you can read a bit about me and try out some of the web apps I\'ve created while learning to program.'
            end

            #---Social Media Icons---
            div(class: 'flex space-x-4 pt-4 md:pt-6 justify-start') do
              a(href: 'https://github.com/thomasridgeon', target: '_blank') do
                img(src: '/images/github-mark.png', alt: 'GitHub Profile', class: 'w-10 h-10')
              end
              a(href: 'https://linkedin.com/in/thomas-ridgeon-72b455370', target: '_blank') do
                img(src: '/images/InBug-Black.png', alt: 'LinkedIn Profile', class: 'w-10 h-10')
              end
            end
          end
        end
      end
    end
  end
end
