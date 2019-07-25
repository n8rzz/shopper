import React from 'react';
import PropTypes from 'prop-types';
import { Notice } from './notice.component';

const DEAFULT_REMOVAL_DELAY = 7000;

export class NoticeContainer extends React.Component {
    constructor(props) {
        super(props);

        this._timer = -1;
        this._updateNoticeVisibilityHandler = this._updateNoticeVisibility.bind(this);
        this.state = {
            isVisible: props.message !== null,
        };
    }

    componentDidMount() {
        if (this.props.message == null) {
            return;
        }

        this._registerRemovalTimer();
    }

    componentWillUnmount() {
        clearTimeout(this._timer);
    }

    _registerRemovalTimer() {
        this._timer = setTimeout(this._updateNoticeVisibilityHandler, DEAFULT_REMOVAL_DELAY);
    }

    _updateNoticeVisibility() {
        this.setState((prevState) => ({ isVisible: !prevState.isVisible }));
    }

    render() {
        return (
            <div
                className={'js-notice'}
            >
                <Notice message={this.props.message} isVisible={this.state.isVisible} />
            </div>
        );
    }
}

NoticeContainer.propTypes = {
    message: PropTypes.string,
};
