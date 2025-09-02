#---Resume Widget-----------
require 'erector'

class ResumePage < Erector::Widget
  def content
    rawtext '<!DOCTYPE html>'
    html do
      head do
        title 'Resume - Thomas Ridgeon'
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
      end

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
            class: 'hidden md:hidden bg-black text-white w-full fixed top-16 left-0 right-0 z-50 px-6 py-4') do
          div(class: 'flex flex-col space-y-4 text-center') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
            a(href: '/resume', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Resume' }
          end
        end
        #----------------

        #---Main content-----
        # outer wrapper
        div(class: 'pt-16') do
          # gray background div
          div(class: 'bg-gray-200 w-full') do
            # profile secion
            div(class: 'flex flex-col md:flex-row items-center md:items-start p-4 md:p-8') do
              img(src: '/images/myphoto.jpg', alt: 'My Photo',
                  class: 'w-56 h-56 md:ml-20 rounded-full')

              div(class: 'mt-6 md:mt-0 md:ml-6 text-center md:text-left') do
                h1(class: 'text-5xl md:text-7xl font-bold') do
                  text 'Thomas Ridgeon'
                end
                p(class: 'text-2xl md:text-4xl font-medium mt-8') do
                  text 'Customs Broker'
                end
              end
            end
          end

          # Two column layout for experience and contact
          div(class: 'flex flex-col md:flex-row mt-10 space-y-10 md:space-y-0 md:space-x-10') do
            # left column (experience):
            div(class: 'w-full md:w-1/2 px-4 md:px-8 py-6 bg-white') do
              h1(class: 'text-xl font-bold') do
                text 'PROFESSIONAL SUMMARY'
              end
              p(class: 'text-lg font-normal mt-4') do
                text 'Multidisciplinary professional with a unique blend of experience across logistics, administration, and academic research. Currently working as a Customs Broker. Recognized for a sharp ability to learn, process, and apply information quickly and effectively.'
              end

              # work experience
              h1(class: 'text-xl font-bold mt-8') do
                text 'WORK EXPERIENCE'
              end
              p(class: 'text-lg font-semibold mt-4') do
                text 'Customs Broker | August 2024 - Present | On-site | Full-time'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'Central Customs Agency Ltd., Barbados'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Handle the clearance of shipments for a portfolio of clients, ensuring compliance with national customs laws and trade regulations.'
                end
                li do
                  text 'Coordinate with government agencies to obtain required permits, licenses, and inspections.'
                end
                li do
                  text 'Work closely with shipping agents to verify documentation and address any issues.'
                end
                li do
                  text 'Represent clients at customs offices, the port, and airport to facilitate smooth and timely clearances.'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Problem Solving · Time Management · Team Collaboration · Client Relations · Attention to Detail · Adaptability · Working Under Pressure'
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Founder and Director | Feb 2022 - Aug 2024 | On-site | Part-time'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'The MMA Hub Ltd., Barbados'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Founded and launched Fight Hub, a Mixed Martial Arts gym, through The MMA Hub Ltd.'
                end
                li do
                  text 'Served as corporate secretary and managed compliance, including annual returns.'
                end
                li do
                  text 'Designed and launched the gym\'s website, managed financials, taught classes, and organized events.'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Corporate Compliance · Leadership & Team Coordination'
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Administrative Officer | Jan 2022 - Jul 2024 | On-site | Full-time'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'Arjay Upholstery & Drapery Ltd., Barbados'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Administered payroll, calculated National Insurance contributions, and managed rental property operations.'
                end
                li do
                  text 'Oversaw tenant relations, invoicing, and rent collection.'
                end
                li do
                  text 'Worked with legal professionals and CAIPO to resolve corporate matters.'
                end
                li do
                  text 'Managed office functions, processed quotations, invoices, and purchase orders, and liaised with clients and suppliers.'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Office Administration · Client Relations · Document Management · Basic Accounting · Corporate Compliance'
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Warehouse Custodian | Jul 2019 - Jul 2021 | On-site | Full-time'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'Serveco Oy., Barbados'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Maintained cleanliness and sanitation across warehouse and office spaces in a logistics terminal'
                end
                li do
                  text 'Operated and maintained cleaning machinery; trained new team members.'
                end
                li do
                  text 'Gained an outsider\'s perspective on logistics operations, which later informed my work as a customs broker.'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Training & Onboarding · Team Collaboration · Attention to Detail · Time Management · Work Ethic & Reliability'
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Freelance Research Assistant | Dec 2019 - Jan 2020 | Remote | Part-time'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'City as a Platform Research Project, Tampere University, Finland'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Worked as a research assistant for a researcher studying how digital platforms shape local governance and interactions.'
                end
                li do
                  text 'Conducted literature reviews, analyzed scholarly articles, and synthesized insights to support outputs.'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Academic Research · Literature Review & Source Evaluation · Critical Thinking · Time Management & Self-Motivation'
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Agricultural Worker | Nov 2017 - Feb 2018 | On-site | Contract'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'PEG Farm and Nature Reserve, Barbados'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Spearheaded a large-scale composting initiative.'
                end
                li do
                  text 'Led a composting workshop.'
                end
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Agricultural Worker / Farm Assistant (Apprenticeship) | Jul 2016 - Sep 2017 | On-site'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'Tmi Pekka Lamppu, Finland'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Immersed in farm life as a live-in apprentice, assisting with crop production and a commercial-scale organic free-range egg-laying operation.'
                end
                li do
                  text 'Led a composting and mushroom cultivation initiative, deepening knowledge of regenerative agriculture and closed-loop systems'
                end
                li do
                  text 'Adapted to working in a multilingual environment; began learning Finnish through daily immersion.'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Work Ethic & Reliability · Adaptability · Project Management · Teamwork · Communication'
              end
              p(class: 'text-lg font-semibold mt-14') do
                text 'Agricultural Worker / Farm Assistant | May 2013 - Aug 2013 | On-site | Contract'
              end
              p(class: 'text-base font-semibold mt-4') do
                text 'Tmi Pekka Lamppu, Finland'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'Assisted with planting, harvesting, field maintenance, and daily operational tasks'
                end
              end
              p(class: 'text-sm font-semibold mt-4 text-gray-600') do
                text 'Skills: Work Ethic & Reliability · Adaptability · Team Collaboration'
              end
            end
            # Right column div:
            div(class: 'w-full md:w-1/2 px-4 md:px-8 py-6 bg-white') do
              # education
              h2(class: 'text-xl font-bold') do
                text 'EDUCATION'
              end
              p(class: 'text-lg font-semibold mt-4') do
                text 'Åbo Akademi University | Sep 2013 - Jun 2016'
              end
              p(class: 'text-lg font-normal mt-4') do
                text 'MPhil, Religious Studies (Laudatur)'
              end
              p(class: 'text-lg font-semibold mt-4') do
                text 'The University of the West Indies, Cave Hill Campus | Sep 2009 - Feb 2013'
              end
              p(class: 'text-lg font-normal mb-4') do
                text 'BA, Theology (First Class Honours)'
              end

              # publications
              h3(class: 'text-xl font-bold mt-8') do
                text 'PUBLICATIONS'
              end
              p(class: 'text-lg font-semibold mt-4') do
                text 'Review of *Mediatization and Religion: Nordic Perspectives*, edited by Stig Hjarvard and Mia Lövheim'
              end
              p(class: 'text-lg font-normal mb-4') do
                text 'Nordic Journal of Migration Research, vol.4, no.4, 2014, pp.219-226'
              end
              a(href: 'https://journal-njmr.org/articles/10.2478/njmr-2014-0021',
                class: 'text-lg font-normal underline mb-4') do
                text 'https://journal-njmr.org/articles/10.2478/njmr-2014-0021'
              end

              # languages
              h4(class: 'text-xl font-bold mt-8') do
                text 'LANGUAGES'
              end
              ul(class: 'list-disc ml-6 mt-2 space-y-2') do
                li do
                  text 'English: Native'
                end
                li do
                  text 'Finnish: Intermediate (B1-B2)'
                end
              end

              # contact
              h5(class: 'text-xl font-bold mt-8') do
                text 'CONTACT'
              end
              p(class: 'text-lg font-normal mt-4') do
                text 'Email: thomas.ridgeon@hotmail.com'
              end
              div(class: 'flex space-x-4 mt-4 mb-8') do
                a(href: 'https://github.com/thomasridgeon', target: '_blank') do
                  img(src: '/images/github-mark.png', alt: 'GitHub Profile', class: 'w-10 h-10 mt-4')
                end
                a(href: 'https://linkedin.com/in/thomas-ridgeon-72b455370', target: '_blank') do
                  img(src: '/images/InBug-Black.png', alt: 'LinkedIn Profile', class: 'w-10 h-10 mt-4')
                end
              end
            end
          end
        end
      end
    end
  end
end
