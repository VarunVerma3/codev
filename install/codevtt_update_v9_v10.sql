
-- this script is to be executed to update CodevTT DB v9 to v10.

-- DB v9 is for CodevTT v0.99.18 (Sept 2012)
-- DB v10 is for CodevTT v0.99.19

-- -----------------



-- WARN create "CodevTT_Type" customField in Mantis before executing this script
INSERT INTO `codev_config_table` (`config_id`, `value`, `type`) VALUES ('customField_type', (select id from mantis_custom_field_table where `name` = 'CodevTT_Type'), 1);


ALTER TABLE codev_config_table ADD `servicecontract_id` int(11) NOT NULL DEFAULT '0' AFTER `team_id`;
ALTER TABLE codev_config_table ADD `commandset_id` int(11) NOT NULL DEFAULT '0' AFTER `servicecontract_id`;
ALTER TABLE codev_config_table ADD `command_id` int(11) NOT NULL DEFAULT '0' AFTER `commandset_id`;

ALTER TABLE codev_config_table DROP PRIMARY KEY;
ALTER TABLE codev_config_table ADD PRIMARY KEY (`config_id`,`team_id`,`project_id`,`user_id`,`servicecontract_id`,`commandset_id`,`command_id`);


-- PERF
CREATE INDEX `project_id` ON `codev_team_project_table` (`project_id`);
CREATE INDEX `team_id` ON `codev_team_project_table` (`team_id`);

CREATE INDEX `command_id` ON `codev_command_bug_table` (`command_id`);
CREATE INDEX `bug_id` ON `codev_command_bug_table` (`bug_id`);

CREATE INDEX `handler_id` ON `mantis_bug_table` (`handler_id`);

-- tag version
UPDATE `codev_config_table` SET `value`='10' WHERE `config_id`='database_version';
