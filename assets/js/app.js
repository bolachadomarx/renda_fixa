// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"
import "preline"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken } })

const HSThemeAppearance = {
  init() {
    const defaultTheme = 'default'
    let theme = localStorage.getItem('hs_theme') || defaultTheme

    if (document.querySelector('html').classList.contains('dark')) return
    this.setAppearance(theme)
  },
  _resetStylesOnLoad() {
    const $resetStyles = document.createElement('style')
    $resetStyles.innerText = `*{transition: unset !important;}`
    $resetStyles.setAttribute('data-hs-appearance-onload-styles', '')
    document.head.appendChild($resetStyles)
    return $resetStyles
  },
  setAppearance(theme, saveInStore = true, dispatchEvent = true) {
    const $resetStylesEl = this._resetStylesOnLoad()

    if (saveInStore) {
      localStorage.setItem('hs_theme', theme)
    }

    if (theme === 'auto') {
      theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'default'
    }

    document.querySelector('html').classList.remove('dark')
    document.querySelector('html').classList.remove('default')
    document.querySelector('html').classList.remove('auto')

    document.querySelector('html').classList.add(this.getOriginalAppearance())

    setTimeout(() => {
      $resetStylesEl.remove()
    })

    if (dispatchEvent) {
      window.dispatchEvent(new CustomEvent('on-hs-appearance-change', { detail: theme }))
    }
  },
  getAppearance() {
    let theme = this.getOriginalAppearance()
    if (theme === 'auto') {
      theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'default'
    }
    return theme
  },
  getOriginalAppearance() {
    const defaultTheme = 'default'
    return localStorage.getItem('hs_theme') || defaultTheme
  }
}
HSThemeAppearance.init()

window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
  if (HSThemeAppearance.getOriginalAppearance() === 'auto') {
    HSThemeAppearance.setAppearance('auto', false)
  }
})

window.addEventListener('load', () => {
  const $clickableThemes = document.querySelectorAll('[data-hs-theme-click-value]')
  const $switchableThemes = document.querySelectorAll('[data-hs-theme-switch]')

  $clickableThemes.forEach($item => {
    $item.addEventListener('click', () => HSThemeAppearance.setAppearance($item.getAttribute('data-hs-theme-click-value'), true, $item))
  })

  $switchableThemes.forEach($item => {
    $item.addEventListener('change', (e) => {
      HSThemeAppearance.setAppearance(e.target.checked ? 'dark' : 'default')
    })

    $item.checked = HSThemeAppearance.getAppearance() === 'dark'
  })

  window.addEventListener('on-hs-appearance-change', e => {
    $switchableThemes.forEach($item => {
      $item.checked = e.detail === 'dark'
    })
  })
})

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

