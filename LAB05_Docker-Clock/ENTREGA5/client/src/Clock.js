// Clock component
import React from 'react';
import Clock2 from 'react-clock';

// Clock class
class Clock extends React.Component {
	// called when clock is initialized
	constructor(props) {
		super(props);
		// sets initial state
		this.state = {
			time: new Date()
		};
	}
	// called when component inserted in DOM
	componentDidMount() {
		// set time interval to make update
		this.intervalID = setInterval(
			() => this.tick(), 
			1000
		);
	}
	// called when component removed from DOM
	componentWillUnmount() {
		clearInterval(this.intervalID);
	}
	tick() {
		// use setState to update state
		this.setState({
			time: new Date()
		});
	}
	// returns element
	render() {
		return (
			<p> 
			<Clock2 value={this.state.time} />
				<h1 class="hora-dig">{this.state.time.toLocaleString()}</h1>
			</p>
		);
	}
}

export default Clock;