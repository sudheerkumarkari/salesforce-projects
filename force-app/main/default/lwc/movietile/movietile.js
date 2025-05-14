import { LightningElement,api } from 'lwc';

export default class MovieTile extends LightningElement 
{
    @api movie;
    @api selectedmovieid;
    clickhandler(event)
    {
        console.log(this.movie.ImdbId);
        const evt=new CustomEvent("searchmovie",{
            detail:this.movie.ImdbId
        });
        this.dispatchEvent(evt);
    }
}