import React from 'react';
import PropTypes from 'prop-types';
import Sticky from 'react-stickynode';
import classnames from 'classnames';
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
        this._onStickyStateChangeHandler = this._onStickyStateChange.bind(this);
        this.state = {
            message: props.message,
            stickyStatus: 0,
        };

        EventService.on(EVENT_NAME.NOTICE_SUCCESS, this._onTriggerNoticeHandler);

        if (this.props.message != null) {
            this._registerRemovalTimer();
        }
    }

    componentWillUnmount() {
        clearTimeout(this._timer);
        EventService.off(EVENT_NAME.NOTICE_SUCCESS, this._onTriggerNoticeHandler);
    }

    _buildClassnames() {
        return classnames({
            'js-notice': true,
            'mix-stickyHeader_isSticky': this.state.message !== '' && this.state.stickyStatus === 2,
        });
    }

    _registerRemovalTimer() {
        if (this._timer !== -1) {
            clearTimeout(this._timer);
        }

        this._timer = setTimeout(this._updateNoticeVisibilityHandler, DEAFULT_REMOVAL_DELAY);
    }

    _onStickyStateChange(event) {
        this.setState({
            stickyStatus: event.status,
        });
    }

    _onTriggerNotice(message) {
        this.setState({ message }, this._registerRemovalTimer);
    }

    _updateNoticeVisibility() {
        this._timer = -1;

        this.setState({
            message: '',
        });
    }

    render() {
        const message = this.state.message != null
            ? this.state.message
            : '';

        if (message.length === 0) {
            return null;
        }

        return (
            <div className={'notice-container'}>
                <Sticky
                    enabled={true}
                    top={0}
                    onStateChange={this._onStickyStateChangeHandler}
                >
                    <div className={this._buildClassnames()}>
                        <Notice message={message} isVisible={this.state.message !== ''} />
                    </div>
                </Sticky>
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
