import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.setConfig();
    }

    toggle() {
        this.setCookieConfig();
        this.setConfig();
    }

    setConfig() {
        // Required on subclasses
    }

    setCookieConfig() {
        const element = document.querySelector(`[data-action="${this.identifier}#toggle"]`)
        document.cookie = `${this.configValue}=${element.checked}; path=/; max-age=31536000`
    }

    getCookie(cookieName = this.configValue) {
        const cookies = document.cookie.split("; ");
        for (const cookie of cookies) {
            const [name, value] = cookie.split("=");
            if (name === cookieName) {
                return value === 'true';
            }
        }
    }
}
