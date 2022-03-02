class EventEmitter {
    constructor() {
        this._storage = new Map();
    }

    addEventListener(type, handler) {
        if (this._storage.has(type)) {
            this._storage.get(type).push(handler);
        } else {
            this._storage.set(type, [handler]);
        }
    }

    removeListener(type, handler) {
        if (this._storage.has(type)) {
            this._storage.set(type, this._storage.get(type).filter((fn) => fn != handler));
            return true;
        }
        return false;
    }

    dispatchEvent(event) {
        if (this._storage.has(event.type)) {
            this._storage.get(event.type).forEach(handler => handler(event));
            return true;
        }
        return false;
    }
}

class JsInteropManager extends EventEmitter {
    constructor() {
        super();
        this.buttonElement = document.createElement('button');
        this.buttonElement.innerText = 'Swap us here ...';

        this.editElement = document.createElement('input');
        this.editElement.value = 'Web';

        window.addEventListener('click', (e) => {
            if (e.target === this.buttonElement) {
                const interopEvent = new JsInteropEvent(1);
                this.dispatchEvent(interopEvent);
            }
        });

        window._clickManager = this;
    }

    getTextFromJs() {
        return this.editElement.value;
    }

    setTextToJs(s) {
        this.editElement.value = s;
    }
}

class JsInteropEvent {
    constructor(value) {
        this.type = 'InteropEvent';
        this.value = value;
    }
}

window.ClicksNamespace = {
    JsInteropManager,
    JsInteropEvent
}
