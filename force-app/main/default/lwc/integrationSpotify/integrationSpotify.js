import { LightningElement, track, wire } from 'lwc';
import searchWithSpotify from '@salesforce/apex/SpotifyIntegration.searchWithSpotify';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SearchSpotify extends LightningElement {
    @track searchTracker = '';
    @track displayResult = false;
    @track trackData = {};
    @track trackUrl = '';
    @track artistName = '';
    @track releaseDate = '';

    changeHandler(event) {
        this.searchTracker = event.target.value;
    }

    async searchTrack() {
        let isValid = this.validateInput();
        if (isValid) {
            try {
                let responseString = await searchWithSpotify({
                    trackName: this.searchTracker
                });
                let response = JSON.parse(responseString);
                if (response && response.tracks && response.tracks.items && response.tracks.items.length > 0) {
                    this.trackData = response.tracks.items[0];
                    this.trackUrl = this.trackData.album.images[0].url;
                    this.artistName = this.getArtistName();
                    this.releaseDate = this.trackData.album.release_date;
                    this.displayResult = true;
                    console.log('response', response);
                } else {
                    this.showToast('No Results', 'No tracks found matching your search.', 'warning');
                    this.resetData();
                }
            } catch (error) {
                this.showToast('Error searching track', error.body.message, 'error');
                console.error('Error searching track:', error);
                this.resetData();
            }
        }
    }

    validateInput() {
        let isValid = true;
        if (!this.searchTracker) {
            this.showToast('Required', 'Please enter a track name to search.', 'error');
            isValid = false;
        }
        return isValid;
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    resetData() {
        this.displayResult = false;
        this.trackData = {};
        this.trackUrl = '';
        this.artistName = '';
        this.releaseDate = '';
    }

    getArtistName() {
        let artistNameArr = this.trackData.artists.map(currItem => currItem.name);
        return artistNameArr.join(', ');
    }
}