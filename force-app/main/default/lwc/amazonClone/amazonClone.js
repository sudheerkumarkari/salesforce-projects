import { LightningElement } from 'lwc';
import login from '@salesforce/apex/LoginUser.login';

export default class AmazonClone extends LightningElement {
    email;
    password;

    handleUserName(event) {
        this.email = event.target.value;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    async handlelogin(event) {
        console.log('Inside Login');
        console.log('Email Value:', this.email);
        console.log('Password:', this.password);

        if (this.email && this.password) {
            try {
                const result = await login({ userName: this.email, password: this.password });
                console.log('Result is:', result);

                if (result === 'ERROR') {
                    alert('Invalid credentials. Please try again.');
                } else {
                    window.location.href = result;
                }
            } catch (error) {
                console.log('Error is:', error);
                alert('Login failed due to an unexpected error.');
            }
        }
    }
}
