import Pikaday from 'pikaday'

window.onload = () => {
  const slice = Array.prototype.slice

  /*
   * Set active nav link
   */
  slice.call(document.querySelectorAll('.torch-nav a'), 0).forEach((field) => {
    let url = window.location.href
    let text = field.innerHTML.toLowerCase()
    let regex = RegExp(`\/${text}`)
    console.log(text)

    if (regex.test(url)) {
      field.classList.add('active')
    }
  })

  /*
   * Prevent empty fields from being submitted, since this breaks Filtrex.
   */
  const formFilters = document.querySelector('form#torch-filters-form')
  if (!formFilters) return

  formFilters.addEventListener('submit', function (e) {
    e.preventDefault()
    console.log('SUBMITTING FORM!')

    let disableFields = false

    slice.call(this.querySelectorAll('.field'), 0).forEach((field) => {
      let text = field.getElementsByTagName('label')[0].textContent
      let start = field.getElementsByClassName('start')[0]
      let end = field.getElementsByClassName('end')[0]

      if (start && end) {
        if (start.value === '' && end.value !== '') {
          window.alert(`Please select a start date for the ${text} field`)
          disableFields = true
        } else if (end.value === '' && start.value !== '') {
          window.alert(`Please select a end at date for the ${text} field`)
          disableFields = true
        }
      }
    })

    slice.call(this.querySelectorAll('input, select'), 0).forEach((field) => {
      console.log(field)
      if (field.value === '') {
        field.disabled = true
      }
    })

    if (!disableFields) {
      e.target.submit()
    }
  })

  slice.call(document.querySelectorAll('select.filter-type'), 0).forEach((field) => {
    field.addEventListener('change', (e) => {
      e.target.nextElementSibling.name = e.target.value
    })
  })

  slice.call(document.querySelectorAll('.datepicker'), 0).forEach((field) => {
    new Pikaday({field: field, theme: 'torch-datepicker'})
  })
}
