import React from 'react';
import PropTypes from 'prop-types';
import EventService from '../../service/event.service';
import { Notice } from './notice.component';
import { EVENT_NAME } from '../../constants/event-names';

const DEAFULT_REMOVAL_DELAY = 7000;

export class NoticeContainer extends React.Component {
    constructor(props) {
        super(props);

        this._timer = -1;
        this._updateNoticeVisibilityHandler = this._updateNoticeVisibility.bind(this);
        this._onTriggerNoticeHandler = this._onTriggerNotice.bind(this);
        this.state = {
            message: props.message,
        };

        EventService.on(EVENT_NAME.NOTICE_SUCCESS, this._onTriggerNoticeHandler);
    }

    componentDidMount() {
        if (this.props.message == null) {
            return;
        }

        this._registerRemovalTimer();
    }

    componentWillUnmount() {
        clearTimeout(this._timer);
        EventService.off(EVENT_NAME.NOTICE_SUCCESS, this._onTriggerNoticeHandler);
    }

    _registerRemovalTimer() {
        this._timer = setTimeout(this._updateNoticeVisibilityHandler, DEAFULT_REMOVAL_DELAY);
    }

    _onTriggerNotice(message) {
        this.setState({ message }, this._registerRemovalTimer);
    }

    _updateNoticeVisibility() {
        this.setState({ message: '' });
    }

    render() {
        const message = this.state.message != null
            ? this.state.message
            : '';

        return (
            <div className={'js-notice'}>
                <Notice message={message} isVisible={this.state.message !== ''} />
            </div>
        );
    }
}

NoticeContainer.propTypes = {
    message: PropTypes.string,
};

NoticeContainer.defaultProps = {
    message: '',
};
