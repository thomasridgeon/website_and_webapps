# Sun Benefits erector Widget
require 'erector'

class SunBenefitsPage < Erector::Widget
  def content
    rawtext '<!DOCTYPE html>'

    html do
      head do
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')
        title 'Sun Benefits'
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
            class: 'hidden md:hidden bg-black text-white w-full fixed top-16 left-0 right-0 z-40 px-6 py-4') do
          div(class: 'flex flex-col space-y-4 text-center') do
            a(href: '/about', class: 'text-lg hover:text-gray-300 transition-colors') { text 'About Me' }
            a(href: '/projects', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Projects' }
            a(href: '/resume', class: 'text-lg hover:text-gray-300 transition-colors') { text 'Resume' }
          end
        end
        #----------------

        #---Main content----

        div(class: 'w-full max-w-2xl px-4 md:ml-20 md:px-6 flex flex-col items-start') do
          div(class: 'max-w-prose w-full')
          h1(class: 'text-3xl md:text-5xl font-bold mt-20 mb-6') do # h1 only needs a bottom margin to space itself from the paragraphs below.
            text 'The Benefits of Sun Exposure'
          end
          h2(class: 'text-lg md:text-xl font-bold my-6') do
            text "Research indicates that vitamin D derived from sunlight exposure surpasses oral supplementation in efficacy due to distinct physiological mechanisms. Here's a clear, concise explanation:"
          end
          h3(class: 'text-lg md:text-xl font-bold my-4') do
            text '1. Transport and Bioavailability'
          end
          p(class: 'text-base md:text-lg mb-4') do
            text 'Sunlight-driven vitamin D₃ binds strongly to vitamin D-binding protein (DBP), giving it longer circulation and more targeted delivery than supplements (Holick et al., 2011; Wacker & Holick, 2013). Supplemental vitamin D₃, absorbed through the gut, binds less to DBP (~60%) and is cleared faster (Haddad et al., 1993). Animal studies confirm that sun-derived vitamin D relies on DBP for full activity, unlike supplements (Safadi et al., 1999).'
          end
          h4(class: 'text-lg md:text-xl font-bold my-4') do
            text '2. Genetic Influences on DBP'
          end
          p(class: 'text-base md:text-lg mb-4') do
            text 'Variants in the DBP gene (e.g., rs7041, rs4588) can weaken supplement response, with carriers of minor alleles up to six times more likely to show poor response to high-dose vitamin D (Fu et al., 2009; Barry et al., 2014). Sun-derived vitamin D, which uses DBP more efficiently, helps overcome these genetic barriers.'
          end
          h5(class: 'text-lg md:text-xl font-bold my-4') do
            text '3. Broader Benefits of Sunlight'
          end
          p(class: 'text-base md:text-lg mb-4') do
            text 'Sunlight produces more than vitamin D: nitric oxide (reduces blood pressure by ~2–5 mmHg; Weller, 2016; Alfredsson, 2020), beta-endorphins (enhance mood and immunity), and circadian signals. These lower risks for hypertension, cardiovascular disease, multiple sclerosis, and some cancers (Hoel et al., 2016). Sunlight also self-regulates vitamin D production, avoiding toxicity risks that can occur with excess supplementation (Holick, 2007; Wacker & Holick, 2013).'
          end
          h5(class: 'text-lg md:text-xl font-bold my-4') do
            text '4. Insights from Dr. Alexander Wunsch'
          end
          p(class: 'text-base md:text-lg mb-4') do
            text 'Wunsch and colleagues emphasize that moderate sun exposure provides “full-spectrum” benefits—including nitric oxide release, beta-endorphin production, and circadian regulation—that supplements cannot replicate (Baggerly et al., 2015).'
          end
          h6(class: 'text-lg md:text-xl font-bold my-4') do
            text 'Conclusion'
          end
          p(class: 'text-base md:text-lg mb-4') do
            text 'Supplements can correct deficiency, but sunlight provides longer-lasting vitamin D, works better across genetic variations, and delivers broader health benefits. For optimal results, aim for safe midday sun exposure (10–15 minutes on arms and legs), adjusted for skin type and location, and consult a healthcare provider for personalized guidance.'
          end

          # References
          div(class: 'space-y-4 mb-6') do
            h1(class: 'text-lg md:text-xl my-6 font-bold underline') do
              text 'References'
            end
            p(class: 'text-sm md:text-base') do
              text 'Holick, M. F., et al. (2011). Vitamin D: A D-Lightful health perspective. Journal of Clinical Endocrinology & Metabolism.'
            end
            a(href: 'https://pmc.ncbi.nlm.nih.gov/articles/PMC3738435/',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://pmc.ncbi.nlm.nih.gov/articles/PMC3738435/'
            end
            p(class: 'text-sm md:text-base') do
              text 'Wacker, M., & Holick, M. F. (2013). Sunlight and vitamin D: A global perspective for health. Dermato-Endocrinology, 5(1).'
            end
            a(href: 'https://www.tandfonline.com/doi/full/10.4161/derm.24494',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://www.tandfonline.com/doi/full/10.4161/derm.24494'
            end
            p(class: 'text-sm md:text-base') do
              text 'Haddad, J. G., et al. (1993). Vitamin D transport and metabolism in humans. Journal of Clinical Investigation.'
            end
            a(href: 'https://ec.europa.eu/health/scientific_committees/scheer/docs/sunbeds_co240m_en.pdf',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://ec.europa.eu/health/scientific_committees/scheer/docs/sunbeds_co240m_en.pdf'
            end
            p(class: 'text-sm md:text-base') do
              text 'Safadi, F. F., et al. (1999). Targeted disruption of the vitamin D-binding protein gene (DBP) in mice. Journal of Clinical Investigation, 103(2), 239–251.'
            end
            a(href: 'https://pubmed.ncbi.nlm.nih.gov/9916136/',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://pubmed.ncbi.nlm.nih.gov/9916136/'
            end
            p(class: 'text-sm md:text-base') do
              text 'Fu, L., et al. (2009). Common genetic variants of the vitamin D-binding protein gene and adverse health outcomes. Journal of Steroid Biochemistry and Molecular Biology, 113(3–5), 227–233.'
            end
            a(href: 'https://pubmed.ncbi.nlm.nih.gov/19302999/',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://pubmed.ncbi.nlm.nih.gov/19302999/'
            end
            p(class: 'text-sm md:text-base') do
              text 'Barry, E. L., et al. (2014). Genetic variants in vitamin D pathways and response to vitamin D supplementation. Journal of Clinical Endocrinology & Metabolism, 99(10), E2133–E2137.'
            end
            a(href: 'https://academic.oup.com/jcem/article/99/10/E2133/2836264',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://academic.oup.com/jcem/article/99/10/E2133/2836264'
            end
            p(class: 'text-sm md:text-base') do
              text 'Weller, R. B. (2016). Sunlight has cardiovascular benefits independently of vitamin D. Blood Purification, 41(1–3), 130–134.'
            end
            a(href: 'https://pubmed.ncbi.nlm.nih.gov/26766556/',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://pubmed.ncbi.nlm.nih.gov/26766556/'
            end
            p(class: 'text-sm md:text-base') do
              text 'Alfredsson, L. (2020). Sunlight exposure and cardiovascular health. International Journal of Environmental Research and Public Health, 17(14), 5014.'
            end
            a(href: 'https://www.mdpi.com/1660-4601/17/14/5014',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://www.mdpi.com/1660-4601/17/14/5014'
            end
            p(class: 'text-sm md:text-base') do
              text 'Hoel, D. G., et al. (2016). The risks and benefits of sun exposure 2016. Dermato-Endocrinology, 8(1).'
            end
            a(
              href: 'https://aspe.hhs.gov/sites/default/files/private/pdf/264486/74-Sunshine-Health-Foundation-IQ-Appeal-Hoel-etal-2016.pdf', class: 'text-sm md:text-base underline break-words'
            ) do
              text 'https://aspe.hhs.gov/sites/default/files/private/pdf/264486/74-Sunshine-Health-Foundation-IQ-Appeal-Hoel-etal-2016.pdf'
            end
            p(class: 'text-sm md:text-base') do
              text 'Holick, M. F. (2007). Vitamin D deficiency. New England Journal of Medicine, 357(3), 266-281.'
            end
            a(href: 'https://www.researchgate.net/publication/6204867_Vitamin_D_Deficiency',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://www.researchgate.net/publication/6204867_Vitamin_D_Deficiency'
            end
            p(class: 'text-sm md:text-base') do
              text 'Baggerly, C. A., et al. (2015). Sunlight and vitamin D: Necessary for public health. Journal of the American College of Nutrition, 34(4), 359–365.'
            end
            a(href: 'https://pubmed.ncbi.nlm.nih.gov/26098394/',
              class: 'text-sm md:text-base underline break-words') do
              text 'https://pubmed.ncbi.nlm.nih.gov/26098394/'
            end
          end
        end
      end
    end
  end
end
