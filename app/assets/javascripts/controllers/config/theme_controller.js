import TogglerController from "controllers/config/toggler_controller"

export default class extends TogglerController {
    configValue = 'dark_mode'

    setConfig() {
        const config = this.getCookie() ? 'dark' : 'light'
        document.body.setAttribute('data-bs-theme', config)
    }
}
