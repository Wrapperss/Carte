import React, { Component } from 'react';
import { View } from 'react-native';

export default class SeparateLine extends Component {

    constructor(props) {
        super(props);
        this.state = {
            width: props.width,
            toLeft: props.toLeft,
        };
    }

    componentWillMount() {
        console.log(this.state.text)
    }

    render() {
        return (
            <View 
            style= {{
                backgroundColor: '#D3D3D3',
                height: 0.5,
                width: this.state.width,
                marginLeft: this.state.toLeft
            }} >
            </View>
        );
    }
}