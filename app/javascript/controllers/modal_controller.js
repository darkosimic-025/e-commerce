import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        this.element.showModal();

        this.turboStreamListener = this.closeModalOnSuccess.bind(this);
        document.addEventListener("turbo:submit-end", this.turboStreamListener);
    }

    disconnect() {
        document.removeEventListener("turbo:submit-end", this.turboStreamListener);
    }

    hideModal() {
        this.element.close();
    }

    closeModalOnSuccess(event) {
        if (event.detail.success) {
            this.hideModal();
        }
    }
}
