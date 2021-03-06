SELECT 
  t1.business_no `business_no`, 
  MAX(t1.responsible) `testResponsible`, 
  MAX(t1.tester) AS `tester`, 
  MAX(t1.modified_date) AS `modifiedDate`, 
  MAX(t1.id) AS `design_id`, 
  MAX(t1.name) `name`, 
  MAX(t1.sub_type) `sub_type`, 
  MAX(t3.id) `id`, 
  MAX(t3.responsible) `responsible`, 
  MAX(t1.domain_id) `domain_id`, 
  IF(
    t3.is_child IS NULL, '0', t3.is_child
  ) `is_child`, 
  MAX(t3.reviewer) `reviewer`, 
  MAX(t1.pi_name) `pi_name`, 
  MAX(t1.process) `process`, 
  MAX(t1.req_test_owner) `req_test_owner`, 
  MAX(t3.start_time) `start_time`, 
  MAX(t1.domain_name) `domain_name`, 
  MAX(t3.end_time) `end_time`, 
  MAX(t3.creator) `creator`, 
  MAX(t3.task_id) `task_id`, 
  MAX(t3.current_status) `current_status`, 
  MAX(t3.check_status) `check_status`, 
  MAX(t3.check_status2) `check_status2`, 
  MAX(t1.plan_id) `plan_id`, 
  MAX(t3.is_mandatory) `is_mandatory`, 
  MAX(t3.reviewe_description) `reviewe_description`, 
  MAX(t3.risk) `risk`, 
  MAX(t3.risk_description) `risk_description`, 
  MAX(t3.task_description) `task_description`, 
  MAX(t3.comment) `comment`, 
  MAX(t3.file_info) `file_info`, 
  MAX(t1.`type`) `type`, 
  MAX(rrmt.groupName) `groupName`, 
  MAX(t1.iterate_id) `iterateId`, 
  MAX(t1.iterate_name) `iterateName`, 
  MAX(rrmt.groupId) `groupId`, 
  MAX(rrmt.htsmValue) `htsmValue` 
FROM 
  test_assignment_tbl t3 
  LEFT JOIN (
    SELECT 
      * 
    FROM 
      (
        (
          SELECT 
            name, 
            business_no, 
            responsible, 
            tester, 
            sub_type, 
            domain_id, 
            assignment_id, 
            t1.id *(-1) id, 
            t1.pi_name, 
            t1.plan_id, 
            t1.process, 
            domain_name, 
            t1.req_test_owner, 
            t1.iterate_id, 
            t1.iterate_name, 
            '1' AS `type`, 
            t1.modified_date 
          FROM 
            test_design_assignment_tbl t2 
            LEFT JOIN test_design_child_tbl t1 ON t2.design_id = t1.id *(-1) 
          where 
            t1.status = '0' 
            and t1.id IS NOT NULL 
            and t1.domain_id = :domainId
        ) 
        UNION 
          (
            SELECT 
              name, 
              business_no, 
              responsible, 
              tester, 
              sub_type, 
              domain_id, 
              assignment_id, 
              t11.id, 
              t11.pi_name, 
              t11.plan_id, 
              t11.process, 
              domain_name, 
              t11.req_test_owner, 
              t11.iterate_id, 
              t11.iterate_name, 
              '0' AS `type`, 
              t11.modified_date 
            FROM 
              test_design_assignment_tbl t2 
              LEFT JOIN test_design_tbl t11 ON t2.design_id = t11.id 
            where 
              t11.status = '0' 
              and t11.id IS NOT NULL 
              and t11.domain_id = :domainId
          )
      ) t2
  ) t1 ON t3.id = t1.assignment_id 
  LEFT JOIN (
    SELECT 
      rmt.group_id AS groupId, 
      rmt.group_name AS groupName, 
      rrt.business_no AS bussinessNo, 
      rmt.htsm_value AS htsmValue, 
      rmt.design_file_num AS dNum, 
      rmt.analysis_detail_file_num AS aNum, 
      rmt.group_htsm_process AS groupHtsmProcess 
    FROM 
      requiregroup_related_tbl rrt 
      LEFT JOIN requiregroup_manage_tbl rmt ON rmt.group_id = rrt.group_id
  ) rrmt ON rrmt.bussinessNo = t1.business_no 
where 
  t1.id IS NOT NULL 
  AND t3.responsible LIKE CONCAT('%', :userName) 
  AND t3.current_status IN (0, 1) 
  AND t1.domain_id = :domainId 
  and t1.business_no LIKE CONCAT('%', :business_no, '%') 
GROUP BY 
  IF(
    t3.is_child IS NULL, '0', t3.is_child
  ), 
  t1.business_no 
order by 
  t1.business_no 
limit 
  :pageNo, 
  :size
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------








SELECT 
  count(*) AS COUNT
FROM
  (
    SELECT
      max(t3.id) id
    FROM
      test_assignment_tbl t3
      LEFT JOIN (
        SELECT
          *
        FROM
          (
            (
              SELECT
                name,
                business_no,
                sub_type,
                domain_id,
                assignment_id,
                t1.id,
                t1.pi_name,
                t1.plan_id,
                t1.process,
                t1.req_test_owner,
                t1.iterate_id,
                '1' AS type
              FROM
                test_design_assignment_tbl t2
                LEFT JOIN test_design_child_tbl t1 ON t2.design_id = t1.id *(-1)
              where
                t1.status = '0'
                and t1.id IS NOT NULL
                and t1.domain_id = :domainId
            )
            UNION
              (
                SELECT
                  name,
                  business_no,
                  sub_type,
                  domain_id,
                  assignment_id,
                  t11.id,
                  t11.pi_name,
                  t11.plan_id,
                  t11.process,
                  t11.req_test_owner,
                  t11.iterate_id,
                  '0' AS type
                FROM
                  test_design_assignment_tbl t2
                  LEFT JOIN test_design_tbl t11 ON t2.design_id = t11.id
                where
                  t11.status = '0'
                  and t11.id IS NOT NULL
                  and t11.domain_id = :domainId
              )
          ) t2
      ) t1 ON t3.id = t1.assignment_id
      LEFT JOIN (
        SELECT
          rmt.group_id AS groupId,
          rmt.group_name AS groupName,
          rrt.business_no AS bussinessNo,
          rmt.htsm_value AS htsmValue,
          rmt.design_file_num AS dNum,
          rmt.analysis_detail_file_num AS aNum,
          rmt.group_htsm_process AS groupHtsmProcess
        FROM
          requiregroup_related_tbl rrt
          LEFT JOIN requiregroup_manage_tbl rmt ON rmt.group_id = rrt.group_id
      ) rrmt ON rrmt.bussinessNo = t1.business_no
    where
      t1.id IS NOT NULL
      AND t3.responsible LIKE CONCAT('%', :userName, '%')
      AND t1.domain_id = :domainId
      AND t3.current_status IN (0, 1)
      and t1.business_no LIKE CONCAT('%', :business_no, '%')
    GROUP BY
      t3.is_child,
      t1.business_no,
      t1.id
  ) tb
  
  
  
  
  
