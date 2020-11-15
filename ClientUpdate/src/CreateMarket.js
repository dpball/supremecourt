import React, {Component} from 'react';
import {Container, TextField, MenuItem, Button,CardMedia} from '@material-ui/core/'
import Typography from '@material-ui/core/Typography'
import generateMetaEvidence from './generate-meta-evidence.js'
import ipfsPublish from './ipfs-publish.js'



// set constants 
const categories = [
{
  value: 'Sports'
},
{
  value: 'Politics'
},
{
  value: 'Misc.'
}
]

const numbers =[1,2,3,4,5]

const enc = new TextEncoder()

// define market creation class 

class CreateMarket extends Component {

  constructor(props) {
    super()
    this.state = {
      category: 'Misc.',
      number: 1,
      title: '',
      description: '',
      question: '',
      options: [],
      optionsDesc: [],
      endTime: 0,
      resultTime: 0,
      initLiq: 0
    }
  }

// set handle change functions
  handleChangeCategory = (event) => {
    this.setState({category: event.target.value})
  }

  handleChangeTitle = (event) => {
    this.setState({title: event.target.value})
  }

  handleChangeDescription = (event) => {
    this.setState({description: event.target.value})
  }

  handleChangeQuestion = (event) => {
    this.setState({question: event.target.value})
  }

  handleChangeNumber = (event) => {
    this.setState({number: event.target.value})
    var q = []
    for(var i=0; i<event.target.value; i++) {
      q.push('')
    }
    this.setState({options: q})
    this.setState({optionsDesc: q})
  }

  handleChangeOption = (ev) => {
    let options = this.state.options
    options[ev.target.id.substring(1)] = ev.target.value
    this.setState({options})
  }

  handleChangeOptionDesc = (e) => {
    let optionsDesc = this.state.optionsDesc
    optionsDesc[e.target.id.substring(1)] = e.target.value
    this.setState({optionsDesc})
  }

  handleChangeEndTime = (event) => {
    this.setState({endTime: event.target.value})
  }

  handleChangeResultTime = (event) => {
    this.setState({resultTime: event.target.value})
  }


  handleChangeinitLiq = (event) => {
    this.setState({initLiq: event.target.value})
  }

  // function to dispure

  handleSubmit = (e) => {
    e.preventDefault()
    let metaevidence = generateMetaEvidence(this.state.title,this.state.category,this.state.description,this.state.question,this.state.options,this.state.optionsDesc,'0xHI')
    console.log(metaevidence)
    ipfsPublish('metaevidence.json',enc.encode(JSON.stringify(metaevidence))).then((ipfsObj) => {
      console.log('/ipfs/'+ipfsObj[1]['hash'] + ipfsObj[0]['path'])
    })
  }

  // render create market bit

  render() {
    return(
      <Container fixed>
      <img style={{ width: "100%"}} src="create_markets.png" />
      <CardMedia style={{ height: "200px" }} image="/market.jpg" />
        <form autocomplete="off">
        <div>
          <TextField required id="title" label="Title" onChange={this.handleChangeTitle} defaultValue="" fullWidth/>
        </div>
        <div>
          <TextField fullWidth select label="Category" value={this.state.category} onChange={this.handleChangeCategory}> {categories.map((option) => (
            <MenuItem key={option.value} value={option.value}>
            {option.value}
            </MenuItem>
    ))}</TextField>
        </div>
        <div>
          <TextField required
            id="standard-multiline-static"
            label="Description"
            multiline
            fullWidth
            rows={4}
            onChange ={this.handleChangeDescription}
          />
        </div>
        <div>
          <TextField required id="question" label="Question" fullWidth onChange={this.handleChangeQuestion}/>
        </div>
        <div>
        <TextField select label="Number of Options" fullWidth value={this.state.number} onChange={this.handleChangeNumber}> {numbers.map((option) => (
          <MenuItem key={option} value={option}>
          {option}
          </MenuItem>
  ))}</TextField>
        </div>
        <div>
        {
          this.state.options.map((option,key) => {
            return(
            <div>
              <TextField label={"Option "+(key+1)} id={"o"+key} value = {this.state.options[key]} onChange={this.handleChangeOption}>
              </TextField>
              <TextField label={"Description "+(key+1)} id={"d"+key} value = {this.state.optionsDesc[key]} onChange={this.handleChangeOptionDesc}>
              </TextField>
            </div>
        )})
        }
        </div>
        <div>
          <TextField label="When to stop accepting bets (UNIX)" fullWidth value={this.state.endTime} onChange={this.handleChangeEndTime}/>
        </div>
        <div>
          <TextField label="When will the answer be known (UNIX)" fullWidth value={this.state.resultTime} onChange={this.handleChangeResultTime}/>
        </div>
        <div>
          <TextField label="Total Initial Liquidity in DAI" fullWidth value={this.state.initLiq} onChange={this.handleChangeinitLiq}/>
        </div>
          <div style={{
            margin: 'auto',
          width: '50%',
          padding: 10
          }}>
          <Button type="submit" size="large" color="primary" variant="contained" component="span" onClick={this.handleSubmit}>Submit</Button>
          </div>
        </form>
        </Container>
    )
  }
}

export default CreateMarket
