import React, {Component} from 'react';
import AppBar from '@material-ui/core/AppBar'
import Typography from '@material-ui/core/Typography'
import Grid from '@material-ui/core/Grid'
import CreateMarket from './CreateMarket'
import Bets from './Bets'
import Arbitrator from './Arbitrator'

import Web3 from 'web3';
import EventContract from './SCEvent.json'
import BigNumber from "bignumber.js"

const ipfs = require("nano-ipfs-store").at("https://ipfs.infura.io:5001");

class App extends Component {

  constructor() {
    super();
    this.state ={
      account: '',
      event: null,
      price: 0,
      matchdata: [],
      endTime: 0,
      resultTime: 0,
      loading: true,
      eventData: [],
      numberOfBets: 1
    }
  }

  async componentDidMount() {
    await this.loadWeb3()
    await this.loadData()
    this.listenForEvents()
  }

  async loadWeb3() {
    if(window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    } else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider)
    } else {
      window.alert('Non-ethereum browser detected. Download metamask!')
    }
  }

  addEventData(title,description,question,options,endTime,resultTime, price) {
    var obj = {
      title: title,
      description: description,
      question: question,
      options: options,
      endTime: endTime,
      resultTime: resultTime,
      price: price
    }
    this.setState({eventData: [...this.state.eventData, obj]})
    console.log(obj)
  }

  async loadData() {
    const web3 = window.web3
    const accounts = await web3.eth.getAccounts()
    this.setState({account: accounts[0]})

    const event = new web3.eth.Contract(EventContract.abi, '0x504f54b86b174604e531C09e80491637A2b18F39')
    this.setState({event})

    var price = [0,0,0]
    price[0] = ((await event.methods.price(1,new BigNumber(18446744073709551616)).call())/1000000).toFixed(2)
    price[1] = ((await event.methods.price(2,new BigNumber(18446744073709551616)).call())/1000000).toFixed(2)
    price[2] = ((await event.methods.price(3,new BigNumber(18446744073709551616)).call())/1000000).toFixed(2)
    this.setState({price})

    console.log(event);
    var endTime = await event.methods.endTimestamp().call()
    var resultTime = await event.methods.resultTimestamp().call()
    this.setState({endTime})
    this.setState({resultTime})

    var matchdata=''
    var output = fetch('https://gateway.ipfs.io/ipfs/QmRJ1Kdu5P36oQnJN6prha1TrGGSicpGmq9Ti2hDP8rBEB')
    .then((response) => response.json())
    .then((responseJSON) => {
      matchdata = responseJSON
      this.setState({matchdata})
      this.addEventData(responseJSON.title, responseJSON.description, responseJSON.question, responseJSON.rulingOptions.descriptions,endTime,resultTime,[price[0],price[1],price[2]])
      this.setState({loading: false})
  });

  //var CID = await ipfs.add('TEST')
  //console.log(CID)
  //console.log(await ipfs.cat(CID))

  }

  listenForEvents = () => {
    //contract.DisputeCreate({}).on('data', (event,error) => {})
  }

  render() {
    if(this.state.loading == false ){
    return(
      <React.Fragment>
      <header>
      <AppBar position="sticky">
        <Typography variant="h6" color="inherit" noWrap>
        Supreme Court
        </Typography>
      </AppBar>
    </header>
    <main>
    <Grid container spacing = {3}>

      <Grid item xs={4}>
        <CreateMarket state={this.state}/>
      </Grid>
      <Grid item xs={4}>
        <Bets state={this.state}/>
      </Grid>
      <Grid item xs={4}>
        <Arbitrator state={this.state}/>
      </Grid>
    </Grid>
    </main>
    </React.Fragment>
  )} else {
    return(
    <div>
    loading
    </div>
    )
    }
  }
}

export default App;
