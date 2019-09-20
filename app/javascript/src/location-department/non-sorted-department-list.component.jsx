import React from 'react';
import PropTypes from 'prop-types';

export function NonSortedDepartmentList(props) {
    const departmentListJsx = props.departments.map((department, index) => (
        <li
            className={'listItem mix-listItem_tight'}
            key={`nonSorted-department-${index}`}
        >
            <div className={'listItem-hd'}>
                <ul className={'stereo'}>
                    <li>
                        <a
                            className={'link'}
                            href={`/departments/${department.id}`}
                        >
                            {department.name}
                        </a>
                    </li>
                    <li>
                        <button
                            className={`btn js-addDepartmentToSort-${department.id}`}
                            type={'button'}
                            onClick={(event) => props.onClickCreateLocationDepartmentHanlder(event, department)}
                        >
                            ADD
                        </button>
                    </li>
                </ul>
            </div>
        </li>
    ));

    return (
        <React.Fragment>
            <div className={'vr_1'}>
                <h3 className={'hdg hdg_3'}>Unsorted Departments</h3>
            </div>
            <ul className={'vlist js-nonSortedDepartmentList'}>
                { departmentListJsx }
            </ul>
        </React.Fragment>
    );
}

NonSortedDepartmentList.propTypes = {
    departments: PropTypes.array.isRequired,
    onClickCreateLocationDepartmentHanlder: PropTypes.func.isRequired,
};
