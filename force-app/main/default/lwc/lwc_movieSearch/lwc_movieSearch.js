import { LightningElement } from 'lwc';
const DELAY=300;
export default class Lwc_movieSearch extends LightningElement {

    selectedvalue='';
    isloading=false;
    selectedsearch='';
    selectedPage="1"
    delayTimeout;
    searchResult=[];
    selectedmovie="";
    get givenoptions(){
        return[
     {label:'Movie',value:'movie' },
     {label:'Series',value:'series' },
     {label:'Episode',value:'episode' },
     {label:'None',value:'none' }
];
}
handleonchange(event)
{
    let{name,value}=event.target;
    this.isloading=true;
    if(name==='type')
    {
        this.selectedvalue=value;
    }
    else if(name==='search')
    {
        this.selectedsearch=value;
    }
    else if(name==='pageno')
    {
        this.selectedPage=value;
    }
    clearTimeout(this.delayTimeout);
    this.delayTimeout=setTimeout(()=>{
        this.searchMovie();
    },DELAY);
    
    
    
}
async searchMovie()
{    
    const url=`https://www.omdbapi.com/?s=${this.selectedsearch}&type=${this.selectedvalue}&page=${this.selectedPage}&apikey=d8db7d4`;
    const res=await fetch(url);
    const data=await res.json();
    console.log("movie search output",data);
    this.isloading=false;
    if(data.Response==='True')
    {
        this.searchResult=data.Search;
    }

}
moviesearchhandler(event)
{
   this.selectedmovie=event.ḍetail;
}
get displaysearchresult(){
    return this.searchResult.length>0 ? true :false;
}
}